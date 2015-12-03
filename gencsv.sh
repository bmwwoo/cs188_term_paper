#!/bin/bash

# TODO CHANGE THIS AS NEEDED
# The 'key' is the file name and the 'value' is the column of the data
FILES=( 'request:3'
        '200:2' )


# NOTE Shouldn't need to change anything down here
TEX='cs188_final.tex'
DIRS=('m3med' 'm3large' 'm3xlarge' 'm32xlarge' 'multi_m3med' 'multi_m3large' \
  'multi_m3xlarge' 'multi_m32xlarge' 'mem_m3large' 'nomem_m3large')

for FILESPEC in "${FILES[@]}"
do
  FILE=${FILESPEC%%:*}
  COL=${FILESPEC#*:}
  AWK='{ printf "%d,%f\n",$1,$'
  AWK+="$COL}"

  SOURCE="$FILE.txt"
  TEMP="$FILE.temp"
  CSV="$FILE.csv"

  for DIR in "${DIRS[@]}"
  do
    # Move into directory
    cd "resources/$DIR/data"

    # Generate the file
    echo 'X,Y' > "$TEMP"
    cat "$SOURCE" | awk "$AWK" >> "$TEMP"

    # Truncate
    head -n 27 "$TEMP" > "$CSV"

    # Cleanup
    rm "$TEMP"

    # Go back to where we started
    cd ../../../
  done
done
# Touch the TEX file so that the make will rebuild it if you call make
touch "$TEX"
