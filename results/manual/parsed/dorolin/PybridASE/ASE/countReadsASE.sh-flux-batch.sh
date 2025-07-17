#!/bin/bash
#FLUX: --job-name=count_reads
#FLUX: --queue=all
#FLUX: -t=6600
#FLUX: --urgency=16

module load vital-it/7
module load UHTS/Analysis/GenomeAnalysisTK/4.1.3.0
samples=$HOME/Style/step02_AxEx/files_AxEx.txt
bamdir=$HOME/Style/step03_AxEx/Pax_genome
filebase=$(cat $samples | awk -v var=$SLURM_ARRAY_TASK_ID 'NR==var {print $1}')
FILE=${bamdir}/${filebase}/Aligned.sortedByCoord.md.sp_RG.bam
mkdir -p ${filebase}/tmp
hostname; date
start_time="$(date -u +%s)"
echo "processing $filebase"
GenomeAnalysisTK ASEReadCounter \
		 -R $HOME/Style/Pax_genome/Petunia_axillaris_304.fa \
		 -I $FILE \
		 -V $HOME/Style/step04_AxEx/Pax_genome/SNPs/cohort_md_snps_filtered_sel.vcf.gz \
		 -O ${filebase}/counts.txt \
		 --disable-read-filter NotDuplicateReadFilter \
		 --min-mapping-quality 60 \
		 --min-base-quality 25 \
		 --tmp-dir ${filebase}/tmp
GenomeAnalysisTK ASEReadCounter \
		 -R $HOME/Style/Pax_genome/Petunia_axillaris_304.fa \
		 -I $FILE \
		 -V $HOME/Style/step04_AxEx/Pax_genome/SNPs/cohort_md_snps_filtered_sel.vcf.gz \
		 -O ${filebase}/counts_md.txt \
		 --min-mapping-quality 60 \
		 --min-base-quality 25 \
		 --tmp-dir ${filebase}/tmp
end_time="$(date -u +%s)"
elaps=$(dc -e "$end_time $start_time - p")
elapstime=`printf '%dh:%dm:%ds\n' $(($elaps/3600)) $(($elaps%3600/60)) $(($elaps%60))`
echo "------------------------------"
echo "ASEReadcounter took $elapstime"
echo "------------------------------"
