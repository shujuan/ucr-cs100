#!/bin/bash

scriptdir=`dirname "$0"`
source "$scriptdir/config.sh"

###############################################################################

function pad {
    ret="${1:0:$2}                                                  "
    ret="${ret:0:$2}"
    echo "$ret"
}

echo "================================================================================"
echo " name                 | cs account | github account   | points      | percent  "
echo "================================================================================"

for file in studentinfo/*; do
    csaccount=`basename $file`
    name=`head -n 1 $file`
    githubaccount=`tail -n 1 $file`
    downloadgrades "$githubaccount"
    
    totalgrade=`totalGrade "$githubaccount"`
    totaloutof=`totalOutOf "$githubaccount"`
    percent=`bc <<< "scale=2; 100 * $totalgrade/$totaloutof"`

    printf " $(pad "$csaccount" 20) |"
    printf " $(pad "$csaccount" 10) |"
    printf " $(pad "$githubaccount" 16) |"
    printf " %4s / %4s | $percent \n" $totalgrade $totaloutof
done

echo "================================================================================"
