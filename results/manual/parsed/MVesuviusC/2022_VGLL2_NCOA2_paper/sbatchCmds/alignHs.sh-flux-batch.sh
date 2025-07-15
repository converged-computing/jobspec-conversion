#!/bin/bash
#FLUX: --job-name=alignHs
#FLUX: -c=10
#FLUX: --queue=general,himem
#FLUX: -t=172800
#FLUX: --priority=16

set -e ### stops bash script if line ends with error
echo ${HOSTNAME} ${SLURM_ARRAY_TASK_ID}
ml purge
ml load GCCcore/8.3.0 \
        Trim_Galore/0.6.5-Java-11.0.2-Python-3.7.4
nameArray=(EGAR00001508614_SARC061
           EGAR00001508618_SARC065
           EGAR00001508623_SARC070-Primary
           EGAR00001508624_SARC070-Relapse1
           EGAR00001508656_SARC102)
baseName=${nameArray[${SLURM_ARRAY_TASK_ID}]}
inputPath=/gpfs0/home1/gdkendalllab/lab/raw_data/fastq/2016_12_14
trim_galore \
    --length 30 \
    -j 8 \
    --paired \
    -o /gpfs0/scratch/mvc002/kendall \
    ${inputPath}/${baseName}.R1.fastq.gz \
    ${inputPath}/${baseName}.R2.fastq.gz
ml purge
ml load GCC/7.3.0-2.30 \
        OpenMPI/3.1.1 \
        SAMtools/1.9
STAR \
    --runMode alignReads \
    --outSAMtype BAM SortedByCoordinate \
    --runThreadN 10 \
    --outFilterMultimapNmax 1 \
    --readFilesCommand zcat \
    --genomeDir ref/starhg38.p4 \
    --readFilesIn /gpfs0/scratch/mvc002/kendall/${baseName}.R1_val_1.fq.gz \
                  /gpfs0/scratch/mvc002/kendall/${baseName}.R2_val_2.fq.gz \
    --outFileNamePrefix output/aligned/Hs/${baseName}
samtools index output/aligned/Hs/${baseName}Aligned.sortedByCoord.out.bam
rm /gpfs0/scratch/mvc002/kendall/${baseName}.R1_val_1.fq.gz \
   /gpfs0/scratch/mvc002/kendall/${baseName}.R2_val_2.fq.gz \
   /gpfs0/scratch/mvc002/kendall/${baseName}.R1.fastq.gz_trimming_report.txt \
   /gpfs0/scratch/mvc002/kendall/${baseName}.R2.fastq.gz_trimming_report.txt
