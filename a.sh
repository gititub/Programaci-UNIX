#! /bin/bash

wget https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt;

wget https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt;

wget https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SampleAttributesDD.xlsx;

wget https://storage.googleapis.com/gtex_analysis_v8/annotations/GTEx_Analysis_v8_Annotations_SubjectPhenotypesDD.xlsx;

ssconvert GTEx_Analysis_v8_Annotations_SubjectPhenotypesDD.xlsx GTEx_Analysis_v8_Annotations_SubjectPhenotypesDD.csv;

ssconvert GTEx_Analysis_v8_Annotations_SampleAttributesDD.xlsx GTEx_Analysis_v8_Annotations_SampleAttributesDD.csv;

truncate -s 1480k GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt

echo ===================================================================
echo "URL del dataset: https://www.gtexportal.org/home/datasets" ;
echo ===================================================================
echo "Mida del fitxer(K):";
du -s GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt;
du -s GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt;
echo ===================================================================
echo "Nombre de registres:";
wc -l GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt;
wc -l GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt;
echo ===================================================================
echo "Nombre de columnes:";
head -n 1 GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt | wc -w;
head -n 1 GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt | wc -w;
echo ===================================================================
while getopts ":vxy" option; do
  case $option in
  	v) echo "Format del fitxer:" ;
  		file -i GTEx_Analysis_v8_Annotations_SampleAttributesDS.txt
  		file -i GTEx_Analysis_v8_Annotations_SubjectPhenotypesDS.txt
  		;;

  	x) echo "Phenotypes file:"
  	   echo "Data type integer:";
  	   grep integer GTEx_Analysis_v8_Annotations_SubjectPhenotypesDD.csv |wc -l;
  	   echo "Data type decimal:";
  	   grep decimal GTEx_Analysis_v8_Annotations_SubjectPhenotypesDD.csv |wc -l;
  	   echo "Data type string:";
  	   grep "string" GTEx_Analysis_v8_Annotations_SubjectPhenotypesDD.csv |wc -l;
  	   echo "SampleAttributes file:";
  	   echo "Data type integer:";
  	   grep "integer" GTEx_Analysis_v8_Annotations_SampleAttributesDD.csv |wc -l;
    	   echo "Data type decimal:";
  	   grep "decimal" GTEx_Analysis_v8_Annotations_SampleAttributesDD.csv |wc -l;
	   echo "Data type string:";
  	   grep "string" GTEx_Analysis_v8_Annotations_SampleAttributesDD.csv |wc -l		
  	;;
	
	y) echo "Data available include:
BAM files for RNA-Seq, Whole Exome Seq, and Whole Genome Seq
Genotype Calls (.vcf) for OMNI SNP Arrays, WES, and WGS
OMNI SNP Array Intensity files (.idat and .gtc)
Affymetrix Expression Array Intensity files (.cel)
Allele Specific Expression (ASE) tables
All expression matrices from the Portal, including samples that did not pass the Analysis Freeze QC
Sample Attributes
Subject Phenotypes"
	;;
	*)
	   echo "Invalid argument. Options:
	   		- v: Format del fitxer
	   		- x: Data type
	   		- y: Data info"
	exit;;
			
  esac
done
shift $((OPTIND-1))




