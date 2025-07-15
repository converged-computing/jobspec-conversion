#!/bin/bash
#FLUX: --job-name=merger
#FLUX: -N=2
#FLUX: -n=20
#FLUX: --queue=fuchs
#FLUX: -t=43200
#FLUX: --priority=16

modus="notest"
reffasta="/scratch/fuchs/agmisc/chiocchetti/ReferenceGenomes/hg38.fa"
refdb="/scratch/fuchs/agmisc/chiocchetti/annovar/humandb/"
filename=$1
echo "the length of filename is ${#filename}"
if [[ ${#filename} == 0  ]] | [[ ! -f $1 ]];
then
    echo "file does not exist or is not specified";
    exit;
else
    echo "$1 is used"
    filename=$(basename $1)
    filedir=$(dirname $1)
fi
homedir=$(pwd)
cd $filedir
if [ "$modus" == "test" ]
then
    echo "modus is test: subset is used"
    if [ -f testset.vcf.gz ]
    then
	echo "using existing testset file; if you want to use an otherone delete or rename testset.vcf.gz in $filedir"
	filename="testset.vcf.gz"
    else
	bcftools query -l $filename | grep 5 > samples.tmp
	bcftools view $filename -S samples.tmp -Oz -o testset.vcf.gz
	filename="testset.vcf.gz"
    fi
fi
echo "run normalization step1"
bcftools norm -m-both --threads 20 -Oz -o 01_merged.vcf.gz $filename
echo "run normalization step2"
bcftools norm -f $reffasta --threads 20 -Oz -o 02_merged.vcf.gz 01_merged.vcf.gz
echo "run annotation"
table_annovar.pl 02_merged.vcf.gz  $refdb \
		 -buildver hg38 \
		 -out Annotated \
		 -remove \
		 -protocol refGene,cytoBand,exac03,avsnp147,dbnsfp30a\
		 -operation gx,r,f,f,f\
		 -nastring . \
		 -vcfinput \
		 -polish\
		 -thread 20\
		 -maxgenethread 20
bcftools query -e 'GT ="."' \
	 -f '%CHROM\t%POS\t%ID\t%REF\t%ALT\t%QUAL\t%Gene.refGene\t%GeneDetail.refGene\t%Func.refGene\t%ExonicFunc.refGene\t%AAChange.refGene\n' \
	 Annotated.hg38_multianno.vcf -threads 20 | \
    grep -E "stop|start|frameshift|splicing" > Annotated.hg38_LDG.txt
echo "done"
cd $homedir
