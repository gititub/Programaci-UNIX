#!/usr/bin/awk

BEGIN {
    split("0 1 2 3 4",nrsArr)
    split("Violenta Natural Unexpected Slow Ventilator_Case",namesArr)
    for (i in nrsArr) {
        nr2name[nrsArr[i]] = namesArr[i]
    }
}
{
    n = split($NF,nrs,/,/)
    sub(/[^[:space:]]+$/,"")
    printf "%s", $0
    for (i=1; i<=n; i++) {
        printf "%s%s", nr2name[nrs[i]], (i<n ? "," : ORS)
    }
}

function print_canvi(){
 	printf "\n\t\t\tDeath classification based on the 4-point Hardy Scale\n\n"
 	printf "1) Violent and fast death Deaths due to accident, blunt force trauma or suicide, terminal phase estimated at < 10 min.\n2) Fast death of natural causes Sudden unexpected deaths of people who had been reasonably healthy, after a terminal phase estimated at < 1 hr (with sudden death from a myocardial infarction as a model cause of death for this category).\n3) Intermediate death Death after a terminal phase of 1 to 24 hrs (not classifiable as 2 or 4); patients who were ill but death was unexpected.\n4) Slow death Death after a long illness, with a terminal phase longer than 1 day (commonly cancer or chronic pulmonary disease); deaths that are not unexpected. \n0) Ventilator Case All cases on a ventilator immediately before death.\n"
 	printf "----------------------------------------------------"
 	printf "-----------------------\n\n"
 	}
 END {print_canvi()}
