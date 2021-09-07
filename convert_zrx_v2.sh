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

csplit "$1" '/ZRXPVERSION2300.100/' {*} -z -f "$splitdir/xx"

if [ ! -d "$outdir" ]; then
  mkdir "$outdir"
fi

for filename in  $splitdir/xx*; do

  SNAME=$(head -n 25 $filename | grep '#' | sed 's/#//g' | sed 's/|//g' | sed 's/*/\n/g' | grep SNAME | sed 's/SNAME//g')
	SANR=$(head -n 25 $filename | grep '#' | sed 's/#//g' | sed 's/|//g' | sed 's/*/\n/g' | grep SANR | sed 's/SANR//g')
	REXCHANGE=$(head -n 25 $filename | grep '#' | sed 's/#//g' | sed 's/|//g' | sed 's/*/\n/g' | grep REXCHANGE | sed 's/REXCHANGE//g')
	DATEFIRST=$(head -n20 $filename | sed -e '/#/ { N; d; }' | sed  's/\s*$//' | sed 's/ /,/g' | head -n1  | awk -F',' '{print $1;}')
  DATELAST=$(tail -n1 $filename  | awk -F' ' '{print $1;}')

	    file=$SNAME"_"$SANR"_"$REXCHANGE"_"$DATEFIRST"_"$DATELAST".csv"
            echo "-------"
            echo "From file: $filename"
            echo "Writing to: $file"

            cat $filename | sed -e '/#/ { N; d; }' | sed  's/\s*$//' | sed 's/ /,/g' > "$outdir/$file"

done
