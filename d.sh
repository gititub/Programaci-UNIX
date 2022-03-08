#!/bin/bash

awk '
BEGIN {print "<table border=2 cellspacing=2 cellpadding=2>"}
{
    print "<tr>"
    if (NR==1) {starttag="th scope=\"col\""; endtag="th"}
    else {starttag="td"; endtag="td"}
    for(i=1;i<=NF;i++) {
        (NR>1 && i==4 && substr($i,0,length($i)-1) >85) ? bg=" style=\"background-color:#ff0000\"" : bg=""
        print "<" starttag bg ">" $i "</" endtag ">"
    }
    print "</tr>"
}
END {print "</table>"}' /home/pscramartinezsequ/directori/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.csv > d.html

