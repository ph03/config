#!/bin/bash

# Check if copyright statements include the current year
# If current year is missing, offer to add it
# A modified version of 
# http://damien.lespiau.name/2013/01/a-git-pre-commit-hook-to-check-year-of.html

mergebase=`git merge-base HEAD origin/master`
files=`git diff $mergebase --name-only`
year=`date +"%Y"`

for f in $files; do
    head -30 $f | grep -i copyright 2>&1 1>/dev/null || continue

    if ! grep -i -e "copyright.*$year" $f 2>&1 1>/dev/null; then
        missing_copyright_files="$missing_copyright_files $f"
    fi
done

if [ -n "$missing_copyright_files" ]; then
    echo "The year $year is missing in the copyright notice of the following files:"
    for f in $missing_copyright_files; do
        echo "    $f"
    done 


    echo "Do you wish to add the copyright year $year to the above files?"
    exec < /dev/tty
    read add
    if [ "$add" = "y" ]; then
        for f in $missing_copyright_files; do
            if grep -i -P -e "copyright.*?[0-9]{4} ?- ?[0-9]{4}" $f 2>&1 1>/dev/null; then
                perl -p -i -e "s/(copyright.*?[0-9]{4}) ?- ?[0-9]{4}.*? /\1-$year /gi" $f
            elif grep -i -P -e "copyright.*?[0-9]{4}" $f 2>&1 1>/dev/null; then
                perl -p -i -e "s/(copyright.*?[0-9]{4}).*? /\1-$year /gi" $f
            else
                perl -p -i -e "s/(copyright \(c\)|copyright).*? /\1 $year /gi" $f
            fi
            echo "Added the year $year to $f"
        done
        exit 1
    else
        exit 0
    fi
    
fi
