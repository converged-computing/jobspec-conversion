#!/bin/bash
#FLUX: --job-name=fastptotxtJune2023
#FLUX: -n=8
#FLUX: --queue=batch
#FLUX: -t=540000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
ml fastp/0.23.2
mkdir processed
for file in rawdata/*R1*
do
  	file2="${file:8:-11}"
        fastp -w 8 -i "$file" -o processed/"$file2""R1A.fastq.gz" -f 23 -A -G -Q -L
done
mkdir filtered
for file in rawdata/*R1*
do
  	file2="${file:8:-11}"
        fastp -w 8 -i "processed/""$file2""R1A.fastq.gz" -I "rawdata/""$file2""R2.fastq.gz" -o "processed/""$file2""R1B.fastq.gz" -O "processed/""$file2""R2B.fastq.gz" -U --umi_loc read1 --umi_len 6 --um$
        fastp -w 8 -i "processed/""$file2""R1B.fastq.gz" -I "processed/"$file2""R2B.fastq.gz" -o "filtered/""$file2""R1.fastq.gz" -O "filtered/""$file2""R2.fastq.gz" -U --umi_loc read2 --umi_len 8 --umi_$
        rmmod fastp/0.23.2
        ml Bowtie2
        mkdir mapped
done
for file in rawdata/*R1*
do
  	file2="${file:8:-11}
        bowtie2 --threads 8 -x /scratch/jts34805/remapdir/W22Build/W22chrscaff --phred33 -X 1000 --no-mixed --no-discordant -1 "filtered/""$file2""R1.fastq.gz" -2 "filtered/""$file2""R2.fastq.gz" -S "map$
        rmmod Bowtie2
        ml SAMtools/1.14-GCC-8.3.0
  samtools view -f 64 -F 4 "dedup/""$file2"".Dedup.bam" | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4$
done
