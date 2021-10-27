# Convet .zrx to .csv

Utility to convert .zrx files from the Province of Bozen meteo stations to .csv.

The script will:
- Split the file. Creating one file for each combination of station-measurement. Saves the resulting files in a folder called splitted_\<filename\>
- Convert the files. Parsing the header and extracting the following info SNAME SANR REXCHANGE DATEFIRST DATELAST. Creating a file with the previous info in the filename and the data in .csv format. Converted files will be written into a folder named converted_\<filename\>

## Version

**convert_zrx_v1.sh** is target to a specific (old) version of the zrx format

**convert_zrx_v2.sh** is target to a specific (new) version of the zrx format

## Usage

For version 1 (old format):
bash convert_zrx_v1.sh test.zrx

For version 2 (new format):
bash convert_zrx_v2.sh test_v2.zrx

You can use this in a linux shell or on windows (either with WSL or with any other linux emulator e.g. Git Bash)

## Reference

It uses a combination of linux utilities such as csplit, awk, cat, sed, etc.

## Limitations

- The header parsing could be certainly improved
- The (some) info from the header are stored in the filename. This approach is effective but suboptimal. Another strategy could be implemented.

