# ------------------------------------------------------------------
# Author:       Giulio Genova
# Email:        giuliogenova89@gmail.com
# Date:         2021-09-07
# Usage:        bash convert_zrx_v1.sh <filename>
# Example:      bash convert_zrx_v1.sh test.zrx
# Description:  Utility to convert .zrx files from the Province of Bozen meteo stations to .csv
# 
# ------------------------------------------------------------------

IFS=$'\n'
splitdir="./splitted_$(basename $1 .zrx)"
outdir="./converted_$(basename $1 .zrx)"


if [ ! -d "$splitdir" ]; then
  mkdir "$splitdir"
fi

csplit "$1" '/Exported/' {*} -z -f "$splitdir/xx"

if [ ! -d "$outdir" ]; then
  mkdir "$outdir"
fi

for filename in  $splitdir/xx*; do
echo $filename

	SNAME=$(awk  -F'#|;\\*;|\\|\\*\\|' '{print $2}' <<< $(head -n 20 $filename | grep  SNAME) | grep SNAME | sed 's/SNAME//')
	SANR=$(awk  -F'#|;\\*;|\\|\\*\\|' '{print $3}' <<< $(head -n 20 $filename | grep  SANR) | grep SANR | sed 's/SANR//')
	TSNAME=$(awk  -F'#|;\\*;|\\|\\*\\|' '{print $3}' <<< $(head -n 20 $filename | grep  TSNAME) | grep TSNAME | sed 's/TSNAME//')
	REXCHANGE=$(awk  -F'#|;\\*;|\\|\\*\\|' '{print $2}' <<< $(head -n 20 $filename | grep  REXCHANGE) | grep REXCHANGE | sed 's/REXCHANGE//')
	DATEFIRST=$(head -n20 $filename | sed -e '/#/ { N; d; }' | sed  's/\s*$//' | sed 's/ /,/g' | head -n1  | awk -F',' '{print $1;}')
  DATELAST=$(tail -n1 $filename  | awk -F' ' '{print $1;}')

	    file=$SNAME"_"$SANR"_"$TSNAME"_"$REXCHANGE"_"$DATEFIRST"_"$DATELAST".csv"
            echo "-------"
            echo "Working on: $file"

            cat $filename | sed -e '/#/ { N; d; }' | sed  's/\s*$//' | sed 's/ /,/g' > "$outdir/$file"

done

