#!/bin/bash

# TODO CHANGE THIS AS NEEDED
FILE='request'


# NOTE Shouldn't need to change anything down here
TEX='cs188_final.tex'
DIRS=('m3med' 'm3large' 'm3xlarge' 'm32xlarge' 'multi_m3med' 'multi_m3large' \
  'multi_m3xlarge' 'multi_m32xlarge')
SOURCE="$FILE.txt"
TEMP="$FILE.temp"
CSV="$FILE.csv"

for DIR in "${DIRS[@]}"
do
  # Move into directory
  cd "resources/$DIR/data"

  # Generate the file
  echo 'X,Y' > "$TEMP"
  cat "$SOURCE" | awk '{ printf "%d,%f\n",$1,$3}' >> "$TEMP"

  # Truncate
  head -n 27 "$TEMP" > "$CSV"

  # Cleanup
  rm "$TEMP"

  # Go back to where we started
  cd ../../../
done

# Touch the TEX file so that the make will rebuild it if you call make
touch "$TEX"
