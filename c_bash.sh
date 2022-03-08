#! /bin/bash

echo "Iniciant execució:";
echo "PID és $$";
echo "Nom del directori:";
echo "$1";
echo "Fitxers del directori $1:";
ls $1;
for filename in $1; 
	do
    		find . -name "*.txt" | awk -v mvCmd='mv "%s" "%s"\n' \
    '{ old=$0;
       sub(/[.]txt$/,".csv");
       printf mvCmd,old,$0;
     }' | sh
done
echo "Fitxers del directori $1 renombrats:";
ls $1;
echo "Treballant sobre cada fitxer...";
ls $1 | while read file;
	do
		echo "Iniciant execució:";
		echo "PID és $$";
		echo "Nom del fitxer:";
		echo "$1/$file";
		echo "Mida del fitxer:";
		ls -sh $1/$file | gawk '{print $1}';
		echo "Nombre de registres:";
		wc -l $1/$file | gawk '{print $1}';
	done
