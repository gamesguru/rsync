#!/bin/bash

files=$(cat exclude-file.txt)
for file in $files
do
    file=${file%/}
    printf "\\n\e[1;31m%s\e[0m\\n" "*/$file"
    find . -wholename \"*/$file\"  -type d
done
