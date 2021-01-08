#!/bin/bash

FILE="$1"
TOC="$(basename "$FILE" .pdf)".txt

echo "Using \"$FILE\" to create \"$TOC\""

echo -n "Add filename to final toc... "
echo "$FILE" > "$TOC"
echo "Done."

echo -n "Extract toc from pdf file... "
mutool show "$FILE" outline >> "$TOC"
echo "Done."

echo -n "Cleanup toc and adding checkboxes... "
sed -Ei "s/[+|]\t(.*)\"(.*)\"\t#([0-9]+),.*/\1 - [ ] \2, S. \3/" "$TOC"
echo "Done."

echo -n "Add newlines between chapters... "
sed -Ei '/^\t/! s/( - \[ \] )/\n\1/' "$TOC"
echo "Done."
