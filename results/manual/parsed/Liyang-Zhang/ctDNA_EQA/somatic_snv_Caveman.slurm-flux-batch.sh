#!/bin/bash
#FLUX: --job-name=Caveman
#FLUX: --queue=small
#FLUX: --urgency=16

export IAMGE_NAME='/lustre/home/acct-medkwf/medkwf4/software/CRUK/dockstore-cgpwxs_3.1.7.sif'
export IAMGE_NAME_WRAPPER='/lustre/home/acct-medkwf/medkwf4/software/CRUK/docker-caveman_v1.0.0.sif'

tumor=$1
normal=$2
baseSuper=`basename ${tumor} .sort.bam`
base=$(echo ${baseSuper} | cut -d'_' -f 2)  # get the filename with basename function
echo "base is ${base}"
echo "Tumor sample is ${tumor}"
echo "Normal sample is ${normal}"
project_dir=/lustre/home/acct-medkwf/medkwf4/results/MRD/CC_data/${base}
mkdir -p ${project_dir}
working_dir=${project_dir}/Caveman
mkdir -p ${working_dir}
annovar=${project_dir}/ANNOVAR
mkdir -p ${annovar}
genome_19=/lustre/home/acct-medkwf/medkwf/database/GATK/hg19/ucsc.hg19.fasta
introns_bed=/lustre/home/acct-medkwf/medkwf4/reference/bed/UCSC_Introns.tsv
export IAMGE_NAME=/lustre/home/acct-medkwf/medkwf4/software/CRUK/dockstore-cgpwxs_3.1.7.sif
export IAMGE_NAME_WRAPPER=/lustre/home/acct-medkwf/medkwf4/software/CRUK/docker-caveman_v1.0.0.sif
cores=4
singularity exec $IAMGE_NAME caveman.pl \
-o ${working_dir} \
-r ${genome_19}.fai \
-tb ${tumor} \
-nb ${normal} \
-ig ${introns_bed} \
-td 1 \
-nd 1 \
-species human \
-sa GRCh37d5 \
-st genomic \
-flag-bed-files /lustre/home/acct-medkwf/medkwf4/reference/dbsnp/dbSnp153Common.bed \
-germline-indel ${working_dir}/test.bed \
-unmatched-vcf ${working_dir}/unmatched-vcf \
-threads 8 \
-normal-protocol WXS \
-tumour-protocol WXS
