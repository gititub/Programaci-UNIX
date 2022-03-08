#! /bin/bash

echo "LLancem a.sh ";
./a.sh;
echo "LLancem b.sh ";
./b.sh;
echo "LLancem c_bash.sh";
./c_bash.sh directori;
echo "LLancem c_awk.awk";
gawk -f c_awk.awk GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.csv;
echo "LLancem d.sh";
./d.sh;
firefox d.html;
echo "Done. Gràcies ;)"
