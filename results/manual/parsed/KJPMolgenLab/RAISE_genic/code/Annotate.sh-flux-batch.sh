#!/bin/bash
#FLUX: --job-name=merger
#FLUX: -N=2
#FLUX: -n=20
#FLUX: --queue=fuchs
#FLUX: -t=288000
#FLUX: --urgency=16

modus="run"
reffasta="/scratch/fuchs/agchiocchetti/public/refdata/hg38.fa"
refdb="/scratch/fuchs/agchiocchetti/chiocchetti/annovar/humandb/"
filename=$1
echo "the length of filename is ${#filename}"
if [[ ${#filename} == 0  ]] | [[ ! -f $filename ]];
then
    echo "file does not exist or is not specified";
    exit;
else
    echo "$filename is used"
    filedir=$(dirname $filename)
    filename=$(basename $filename)
fi
homedir=$(pwd)
cd $filedir
if [ "$modus" == "test" ]
then
    echo "modus is test: subset is used"
    if [ -f testset.vcf.gz ]
    then
	echo "using existing testset file; 
if you want to use anotherone delete or rename testset.vcf.gz in $filedir"
	filename="testset.vcf.gz"
    else
	echo "testset is created"
	bcftools query -l $filename | grep 21 > samples.tmp #selects all samples with a 21 in it is kind of arbitrary
	bcftools view $filename -S samples.tmp -Oz -o testset.vcf.gz
	filename="testset.vcf.gz"
	rm samples.tmp
	echo "testset succesfully created"
    fi
fi
bcftools index -f $filename
if [ "$modus" == "test" ]
then
    bcftools view --regions chr1 $filename --threads 20 -o tmp.vcf
else
    bcftools view $filename --threads 20 -o tmp.vcf
fi
echo "run normalization step1"
bcftools norm -m-both --threads 20 -o 01_merged.vcf tmp.vcf
echo "run normalization step2"
bcftools norm 01_merged.vcf -f $reffasta --threads 20  -Oz -o  tmp_02_merged.vcf.gz
bcftools index tmp_02_merged.vcf.gz
echo "run annotation"
table_annovar.pl tmp_02_merged.vcf.gz  $refdb \
		 -buildver hg38 \
		 -out Annotated \
		 -remove \
		 -protocol refGene,avsnp147,dbnsfp30a\
		 -operation g,f,f\
		 -nastring . \
		 -vcfinput \
		 -polish\
		 -thread 20\
		 -maxgenethread 20
htsfile -h  Annotated.hg38_multianno.vcf > tmp_LGD.vcf
sed '/^#/d' Annotated.hg38_multianno.vcf > tmp.vcf
grep -E "stop|start|frameshift|splicing" tmp.vcf >> tmp_LGD.vcf
bgzip -c -@ 20 tmp_LGD.vcf > LGD_$filename
bcftools index LGD_$filename
plink --vcf  LGD_$filename --double-id --make-bed --out LGD_$filename
plink --bfile LGD_$filename --recode "A" --out LGD_$filename
rm tmp*
rm Annotated*
echo "done"
cd $homedir
