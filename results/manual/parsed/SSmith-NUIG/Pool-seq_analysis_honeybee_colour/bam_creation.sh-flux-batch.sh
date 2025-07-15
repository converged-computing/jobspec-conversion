#!/bin/bash
#FLUX: --job-name="align_col"
#FLUX: --priority=16

source /home/ssmith/.bashrc
source activate wgs_env
sample_name=$(awk -v pattern="$SLURM_ARRAY_TASK_ID"  -F',' '$1 == pattern { print $2 }' /data2/ssmith/novo2name.csv)
file_name_1=$(basename /data2/ssmith/fastqs/"$SLURM_ARRAY_TASK_ID"_"$sample_name"_1.fq.gz)
file_name_2=$(basename /data2/ssmith/fastqs/"$SLURM_ARRAY_TASK_ID"_"$sample_name"_2.fq.gz)
echo BEGINNING FASTQC SCRIPT
dirPath=/data2/ssmith/fastqs/
fastqc "$dirPath""$SLURM_ARRAY_TASK_ID"_*.fq.gz --noextract -t 6 -a /data2/ssmith/adapters.txt --outdir=/data2/ssmith/QC/initial_QC/
echo TRIMMOMATIC ADAPTER TRIMMING
trimmomatic \
PE \
/data2/ssmith/fastqs/"$SLURM_ARRAY_TASK_ID"_"$sample_name"_1.fq.gz \
/data2/ssmith/fastqs/"$SLURM_ARRAY_TASK_ID"_"$sample_name"_2.fq.gz \
/data2/ssmith/trimmed/"$file_name_1" /data2/ssmith/discarded/"$file_name_1" \
/data2/ssmith/trimmed/"$file_name_2" /data2/ssmith/discarded/"$file_name_2" \
ILLUMINACLIP:/data2/ssmith/adapters.fa:2:30:10 \
MINLEN:50
echo BEGINNING FASTQC SCRIPT
dirPath=/data2/ssmith/trimmed/
fastqc "$dirPath""$SLURM_ARRAY_TASK_ID"_*.fq.gz --noextract -t 6 -a /data2/ssmith/adapters.txt --outdir=/data2/ssmith/QC/after_QC/
echo BWA-MEM2 ALIGNMENT
bwa-mem2 mem -t 4 /data/ssmith/c_l_genome/apis_c_l_genome.fa  \
/data2/ssmith/trimmed/"$SLURM_ARRAY_TASK_ID"_"$sample_name"_1.fq.gz \
/data2/ssmith/trimmed/"$SLURM_ARRAY_TASK_ID"_"$sample_name"_2.fq.gz \
| samtools sort -@ 4 -o /data2/ssmith/bams/"$SLURM_ARRAY_TASK_ID"_"$sample_name".sorted.bam
sortedPath=/data2/ssmith/bams
echo SAMTOOLS FLAGSTAT
samtools flagstat "$sortedPath"/"$SLURM_ARRAY_TASK_ID"_"$sample_name".sorted.bam \
> /data2/ssmith/QC/initial_QC/"$SLURM_ARRAY_TASK_ID"_"$sample_name".txt
echo PICARD MARK DUPLICATES 
picard MarkDuplicates \
I="$sortedPath"/"$SLURM_ARRAY_TASK_ID"_"$sample_name".sorted.bam \
M=/data2/ssmith/QC/after_QC/"$SLURM_ARRAY_TASK_ID"_"$sample_name"_dup_metrics.txt \
O="$sortedPath"/"$SLURM_ARRAY_TASK_ID"_"$sample_name".sorted.dupM.bam
rm "$sortedPath"/"$SLURM_ARRAY_TASK_ID"_"$sample_name".sorted.bam
echo PICARD COLLEGE WGS METRICS
picard CollectWgsMetrics \
I="$sortedPath"/"$SLURM_ARRAY_TASK_ID"_"$sample_name".sorted.dupM.bam \
O=/data2/ssmith/QC/after_QC/"$SLURM_ARRAY_TASK_ID"_"$sample_name"_collect_wgs_metrics.txt \
R=/data/ssmith/c_l_genome/apis_c_l_genome.fa
echo SAMTOOLS FLAGSTAT
samtools flagstat "$sortedPath"/"$SLURM_ARRAY_TASK_ID"_"$sample_name".sorted.dupM.bam \
> /data2/ssmith/QC/after_QC/"$SLURM_ARRAY_TASK_ID"_"$sample_name".txt
echo PICARD ADD OR REPLACE GROUPS
picard AddOrReplaceReadGroups \
I=/data2/ssmith/bams/"$SLURM_ARRAY_TASK_ID"_"$sample_name".sorted.dupM.bam \
O=/data2/ssmith/bams/"$SLURM_ARRAY_TASK_ID"_"$sample_name".grpd.bam \
RGID=1 \
RGLB=lib1 \
RGPL=ILLUMINA \
RGPU=unit1 \
RGSM=A_"$SLURM_ARRAY_TASK_ID"
rm /data2/ssmith/bams/"$SLURM_ARRAY_TASK_ID"_"$sample_name".sorted.dupM.bam
samtools index /data2/ssmith/bams/"$SLURM_ARRAY_TASK_ID"_"$sample_name".grpd.bam
lofreq indelqual --dindel \
--ref /data/ssmith/c_l_genome/apis_c_l_genome.fa \
-o /data2/ssmith/bams/"$SLURM_ARRAY_TASK_ID"_"$sample_name"_indels.bam \
/data2/ssmith/bams/"$SLURM_ARRAY_TASK_ID"_"$sample_name".grpd.bam
rm /data2/ssmith/bams/"$SLURM_ARRAY_TASK_ID"_"$sample_name".grpd.bam
rm /data2/ssmith/bams/"$SLURM_ARRAY_TASK_ID"_"$sample_name".grpd.bam.bai
samtools index /data2/ssmith/bams/"$SLURM_ARRAY_TASK_ID"_"$sample_name"_indels.bam
