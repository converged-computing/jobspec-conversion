#!/bin/bash
#FLUX: --job-name=bam
#FLUX: -n=12
#FLUX: --queue=quanah
#FLUX: -t=172800
#FLUX: --urgency=16

module load intel java bwa samtools
workdir=/lustre/scratch/jmanthey/01b_certhia_genomics2
basename_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/basenames.txt | tail -n1 )
refgenome=/home/jmanthey/references/06_certhia_reordered.fasta
/lustre/work/jmanthey/bbmap/bbduk.sh in1=${workdir}/00_fastq/${basename_array}_R1.fastq.gz in2=${workdir}/00_fastq/${basename_array}_R2.fastq.gz out1=${workdir}/01_cleaned/${basename_array}_R1.fastq.gz out2=${workdir}/01_cleaned/${basename_array}_R2.fastq.gz minlen=50 ftl=10 qtrim=rl trimq=10 ktrim=r k=25 mink=7 ref=/lustre/work/jmanthey/bbmap/resources/adapters.fa hdist=1 tbo tpe
bwa mem -t 12 ${refgenome} ${workdir}/01_cleaned/${basename_array}_R1.fastq.gz ${workdir}/01_cleaned/${basename_array}_R2.fastq.gz > ${workdir}/01_bam_files/${basename_array}.sam
samtools view -b -S -o ${workdir}/01_bam_files/${basename_array}.bam ${workdir}/01_bam_files/${basename_array}.sam
rm ${workdir}/01_bam_files/${basename_array}.sam
/lustre/work/jmanthey/gatk-4.1.0.0/gatk CleanSam -I ${workdir}/01_bam_files/${basename_array}.bam -O ${workdir}/01_bam_files/${basename_array}_cleaned.bam
rm ${workdir}/01_bam_files/${basename_array}.bam
/lustre/work/jmanthey/gatk-4.1.0.0/gatk SortSam -I ${workdir}/01_bam_files/${basename_array}_cleaned.bam -O ${workdir}/01_bam_files/${basename_array}_cleaned_sorted.bam --SORT_ORDER coordinate
rm ${workdir}/01_bam_files/${basename_array}_cleaned.bam
/lustre/work/jmanthey/gatk-4.1.0.0/gatk AddOrReplaceReadGroups -I ${workdir}/01_bam_files/${basename_array}_cleaned_sorted.bam -O ${workdir}/01_bam_files/${basename_array}_cleaned_sorted_rg.bam --RGLB 1 --RGPL illumina --RGPU unit1 --RGSM ${basename_array}
rm ${workdir}/01_bam_files/${basename_array}_cleaned_sorted.bam
/lustre/work/jmanthey/gatk-4.1.0.0/gatk MarkDuplicates --REMOVE_DUPLICATES true --MAX_FILE_HANDLES_FOR_READ_ENDS_MAP 100 -M ${workdir}/01_bam_files/${basename_array}_markdups_metric_file.txt -I ${workdir}/01_bam_files/${basename_array}_cleaned_sorted_rg.bam -O ${workdir}/01_bam_files/${basename_array}_final.bam
rm ${workdir}/01_bam_files/${basename_array}_cleaned_sorted_rg.bam
samtools index ${workdir}/01_bam_files/${basename_array}_final.bam
