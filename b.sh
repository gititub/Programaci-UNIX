#! /bin/bash

#wget https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt;
#wget https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt;
#truncate -s 1480k GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt

echo "Quin és el tipus de mort més freqüent per gènere?";
echo "Per al gènere home:";
gawk '{if ($2 == "1") print $4;}' GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt |sort |uniq -c |sort -n -r;
echo "Per al gènere dona:";
gawk '{if ($2 == "2") print $4;}' GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt |sort |uniq -c |sort -n -r;
echo "Quin és el rang d'edat més freqüent en què es tenen mostres?";
gawk '{print $3}' GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt |sort |uniq -c |sort -n -r;
echo "Quants tipus de regions de cervell podem trobar?";
gawk 'BEGIN {FS="\t"}{print $7}' GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | grep "Brain*" |sort |uniq | wc -l;
gawk 'BEGIN {FS="\t"}{print $7}' GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | grep "Brain*" |sort |uniq;
echo "Quin és el pacient que més mostres té?";
gawk 'BEGIN {FS="\t"}{print $1}' GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | gawk '{gsub(/-/, "\t", $1); print}' | gawk '{print $1,$2}' | sort |uniq -c |sort -n -r | head -n 1;
echo "Quines són les 7 mostres que tenen més Split Reads?";
gawk 'BEGIN {FS="\t"}{printf "%s %d\n", $1, $55}' GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | sort -k2nr | head -7;
echo "Quantes dones han mort de manera violenta i tenen mostres de sang?";
gawk '{if ($2 == "2") print $1,$4;}' GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt | gawk '{if ($2 == "1") print $1;}' | gawk '{gsub(/-/, "\t", $1);print}'|sort > dones1.txt;
gawk 'BEGIN {FS="\t"}{print $1,$6,$48}' GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | grep "Blood" | grep -v "Vessel"|gawk '{gsub(/-/, "\t", $1);print}'|sort > mostresSang.txt;
join -1 2 -2 2 dones1.txt mostresSang.txt | gawk '{ print $1 }' | sort | uniq | wc -l;
echo "¿I quina és la mitjana de mapped unique d'aquestes?";
join -1 2 -2 2 dones1.txt mostresSang.txt | gawk '{if ($8 != "") print $8;}' |sort | gawk 'BEGIN{t=0}{t=t+$1}END {print t/NR}';

