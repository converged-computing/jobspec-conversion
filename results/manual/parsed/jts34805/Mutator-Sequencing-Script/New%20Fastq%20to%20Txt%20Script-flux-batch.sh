#!/bin/bash
#FLUX: --job-name=fastptotxt
#FLUX: -c=8
#FLUX: --queue=batch
#FLUX: -t=259200
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
ml fastp/0.23.2
fastp -i Rawdata/NA14-11-LEAF_R1_001.fastq.gz -o processed/NA14-11-LEAF_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA14-11-LEAF_R1A_001.fastq.gz -I Rawdata/NA14-11-LEAF_R2_001.fastq.gz -o processed/NA14-11-LEAF_R1B_001.fastq.gz -O processed/NA14-11-LEAF_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA14-9-LEAF_R1_001.fastq.gz -o processed/NA14-9-LEAF_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA14-9-LEAF_R1A_001.fastq.gz -I Rawdata/NA14-9-LEAF_R2_001.fastq.gz -o processed/NA14-9-LEAF_R1B_001.fastq.gz -O processed/NA14-9-LEAF_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA17-12-LEAF_R1_001.fastq.gz -o processed/NA17-12-LEAF_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i  processed/NA17-12-LEAF_R1A_001.fastq.gz -I Rawdata/NA17-12-LEAF_R2_001.fastq.gz -o processed/NA17-12-LEAF_R1B_001.fastq.gz -O processed/NA17-12-LEAF_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA17-22-LEAF_R1_001.fastq.gz -o processed/NA17-22-LEAF_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA17-22-LEAF_R1A_001.fastq.gz -I Rawdata/NA17-22-LEAF_R2_001.fastq.gz -o processed/NA17-22-LEAF_R1B_001.fastq.gz -O processed/NA17-22-LEAF_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA17-23-LEAF_R1_001.fastq.gz -o processed/NA17-23-LEAF_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i  processed/NA17-23-LEAF_R1A_001.fastq.gz -I Rawdata/NA17-23-LEAF_R2_001.fastq.gz -o processed/NA17-23-LEAF_R1B_001.fastq.gz -O processed/NA17-23-LEAF_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA17-24-LEAF_R1_001.fastq.gz -o processed/NA17-24-LEAF_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA17-24-LEAF_R1A_001.fastq.gz -I Rawdata/NA17-24-LEAF_R2_001.fastq.gz -o processed/NA17-24-LEAF_R1B_001.fastq.gz -O processed/NA17-24-LEAF_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA14-8-LEAF_R1_001.fastq.gz -o processed/NA14-8-LEAF_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA14-8-LEAF_R1A_001.fastq.gz -I Rawdata/NA14-8-LEAF_R2_001.fastq.gz -o processed/NA14-8-LEAF_R1B_001.fastq.gz -O processed/NA14-8-LEAF_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA13-7-Leaf_R1_001.fastq.gz -o processed/NA13-7-LEAF_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA13-7-LEAF_R1A_001.fastq.gz -I Rawdata/NA13-7-Leaf_R2_001.fastq.gz -o processed/NA13-7-LEAF_R1B_001.fastq.gz -O processed/NA13-7-LEAF_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA17-12-POLLEN_R1_001.fastq.gz -o processed/NA17-12-POLLEN_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA17-12-POLLEN_R1A_001.fastq.gz -I Rawdata/NA17-12-POLLEN_R2_001.fastq.gz -o processed/NA17-12-POLLEN_R1B_001.fastq.gz -O processed/NA17-12-POLLEN_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA17-22-POLLEN_R1_001.fastq.gz -o processed/NA17-22-POLLEN_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA17-22-POLLEN_R1A_001.fastq.gz -I Rawdata/NA17-22-POLLEN_R2_001.fastq.gz -o processed/NA17-22-POLLEN_R1B_001.fastq.gz -O processed/NA17-22-POLLEN_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA17-23-POLLEN_R1_001.fastq.gz -o processed/NA17-23-POLLEN_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA17-23-POLLEN_R1A_001.fastq.gz -I Rawdata/NA17-23-POLLEN_R2_001.fastq.gz -o processed/NA17-23-POLLEN_R1B_001.fastq.gz -O processed/NA17-23-POLLEN_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -i Rawdata/NA17-24-POLLEN_R1_001.fastq.gz -o processed/NA17-24-POLLEN_R1A_001.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA17-24-POLLEN_R1A_001.fastq.gz -I Rawdata/NA17-24-POLLEN_R2_001.fastq.gz -o processed/NA17-24-POLLEN_R1B_001.fastq.gz -O processed/NA17-24-POLLEN_R2B_001.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h /scratch/jts34805/fastp.html -A -G -Q -L
fastp -w 8 -i processed/NA14-11-LEAF_R1B_001.fastq.gz -I processed/NA14-11-LEAF_R2B_001.fastq.gz -o filtered/NA14-11-LEAF_R1_001.fastq.gz -O filtered/NA14-11-LEAF_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA14-8-LEAF_R1B_001.fastq.gz -I processed/NA14-8-LEAF_R2B_001.fastq.gz -o filtered/NA14-8-LEAF_R1_001.fastq.gz -O filtered/NA14-8-LEAF_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA14-9-LEAF_R1B_001.fastq.gz -I processed/NA14-9-LEAF_R2B_001.fastq.gz -o filtered/NA14-9-LEAF_R1_001.fastq.gz -O filtered/NA14-9-LEAF_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA17-12-LEAF_R1B_001.fastq.gz -I processed/NA17-12-LEAF_R2B_001.fastq.gz -o filtered/NA17-12-LEAF_R1_001.fastq.gz -O filtered/NA17-12-LEAF_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA17-22-LEAF_R1B_001.fastq.gz -I processed/NA17-22-LEAF_R2B_001.fastq.gz -o filtered/NA17-22-LEAF_R1_001.fastq.gz -O filtered/NA17-22-LEAF_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA17-23-LEAF_R1B_001.fastq.gz -I processed/NA17-23-LEAF_R2B_001.fastq.gz -o filtered/NA17-23-LEAF_R1_001.fastq.gz -O filtered/NA17-23-LEAF_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA17-24-LEAF_R1B_001.fastq.gz -I processed/NA17-24-LEAF_R2B_001.fastq.gz -o filtered/NA17-24-LEAF_R1_001.fastq.gz -O filtered/NA17-24-LEAF_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA13-7-LEAF_R1B_001.fastq.gz -I processed/NA13-7-LEAF_R2B_001.fastq.gz -o filtered/NA13-7-LEAF_R1_001.fastq.gz -O filtered/NA13-7-LEAF_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA17-12-POLLEN_R1B_001.fastq.gz -I processed/NA17-12-POLLEN_R2B_001.fastq.gz -o filtered/NA17-12-POLLEN_R1_001.fastq.gz -O filtered/NA17-12-POLLEN_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA17-22-POLLEN_R1B_001.fastq.gz -I processed/NA17-22-POLLEN_R2B_001.fastq.gz -o filtered/NA17-22-POLLEN_R1_001.fastq.gz -O filtered/NA17-22-POLLEN_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA17-23-POLLEN_R1B_001.fastq.gz -I processed/NA17-23-POLLEN_R2B_001.fastq.gz -o filtered/NA17-23-POLLEN_R1_001.fastq.gz -O filtered/NA17-23-POLLEN_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
fastp -w 8 -i processed/NA17-24-POLLEN_R1B_001.fastq.gz -I processed/NA17-24-POLLEN_R2B_001.fastq.gz -o filtered/NA17-24-POLLEN_R1_001.fastq.gz -O filtered/NA17-24-POLLEN_R2_001.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/adapter.fa
rmmod fastp/0.23.2
ml Bowtie2/2.4.2-GCC-10.2.0
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA14-11-LEAF_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA14-11-LEAF_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA14-11-LEAFmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA14-8-LEAF_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA14-8-LEAF_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA14-8-LEAFmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA14-9-LEAF_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA14-9-LEAF_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA14-9-LEAFmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA17-12-LEAF_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA17-12-LEAF_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA17-12-LEAFmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA17-22-LEAF_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA17-22-LEAF_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA17-22-LEAFmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA17-23-LEAF_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA17-23-LEAF_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA17-23-LEAFmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA17-24-LEAF_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA17-24-LEAF_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA17-24-LEAFmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA13-7-LEAF_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA13-7-LEAF_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA13-7-LEAFmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA17-12-POLLEN_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA17-12-POLLEN_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA17-12-POLLENmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA17-22-POLLEN_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA17-22-POLLEN_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA17-22-POLLENmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA17-23-POLLEN_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA17-23-POLLEN_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA17-23-POLLENmapped.sam
bowtie2 --threads 8 -x /scratch/jts34805/W22Genome/W22 --phred33 -X 1000 --no-mixed --no-discordant -1 /scratch/jts34805/filtered/NA17-24-POLLEN_R1_001.fastq.gz -2 /scratch/jts34805/filtered/NA17-24-POLLEN_R2_001.fastq.gz -S /scratch/jts34805/mapped/NA17-24-POLLENmapped.sam
rmmod Bowtie2
ml SAMtools/1.14-GCC-8.3.0
samtools view -@ 8 -b -o mapped/NA14-11-LEAFmapped.bam  mapped/NA14-11-LEAFmapped.sam
samtools sort -@ 8 mapped/NA14-11-LEAFmapped.bam -o mapped/NA14-11-LEAFmapped.bam
samtools index -@ 8 mapped/NA14-11-LEAFmapped.bam
samtools view -@ 8 -b -o mapped/NA14-8-LEAFmapped.bam  mapped/NA14-8-LEAFmapped.sam
samtools sort -@ 8 mapped/NA14-8-LEAFmapped.bam -o mapped/NA14-8-LEAFmapped.bam
samtools index -@ 8 mapped/NA14-8-LEAFmapped.bam
samtools view -@ 8 -b -o mapped/NA14-9-LEAFmapped.bam  mapped/NA14-9-LEAFmapped.sam
samtools sort -@ 8 mapped/NA14-9-LEAFmapped.bam -o mapped/NA14-9-LEAFmapped.bam
samtools index -@ 8 mapped/NA14-9-LEAFmapped.bam
samtools view -@ 8 -b -o mapped/NA17-12-LEAFmapped.bam  mapped/NA17-12-LEAFmapped.sam
samtools sort -@ 8 mapped/NA17-12-LEAFmapped.bam -o mapped/NA17-12-LEAFmapped.bam
samtools index -@ 8 mapped/NA17-12-LEAFmapped.bam
samtools view -@ 8 -b -o mapped/NA17-22-LEAFmapped.bam  mapped/NA17-22-LEAFmapped.sam
samtools sort -@ 8 mapped/NA17-22-LEAFmapped.bam -o mapped/NA17-22-LEAFmapped.bam
samtools index -@ 8 mapped/NA17-22-LEAFmapped.bam
samtools view -@ 8 -b -o mapped/NA17-23-LEAFmapped.bam  mapped/NA17-23-LEAFmapped.sam
samtools sort -@ 8 mapped/NA17-23-LEAFmapped.bam -o mapped/NA17-23-LEAFmapped.bam
samtools index -@ 8 mapped/NA17-23-LEAFmapped.bam
samtools view -@ 8 -b -o mapped/NA17-24-LEAFmapped.bam  mapped/NA17-24-LEAFmapped.sam
samtools sort -@ 8 mapped/NA17-24-LEAFmapped.bam -o mapped/NA17-24-LEAFmapped.bam
samtools index -@ 8 mapped/NA17-24-LEAFmapped.bam
samtools view -@ 8 -b -o mapped/NA13-7-LEAFmapped.bam  mapped/NA13-7-LEAFmapped.sam
samtools sort -@ 8 mapped/NA13-7-LEAFmapped.bam -o mapped/NA13-7-LEAFmapped.bam
samtools index -@ 8 mapped/NA13-7-LEAFmapped.bam
samtools view -@ 8 -b -o mapped/NA17-12-POLLENmapped.bam  mapped/NA17-12-POLLENmapped.sam
samtools sort -@ 8 mapped/NA17-12-POLLENmapped.bam -o mapped/NA17-12-POLLENmapped.bam
samtools index -@ 8 mapped/NA17-12-POLLENmapped.bam
samtools view -@ 8 -b -o mapped/NA17-22-POLLENmapped.bam  mapped/NA17-22-POLLENmapped.sam
samtools sort -@ 8 mapped/NA17-22-POLLENmapped.bam -o mapped/NA17-22-POLLENmapped.bam
samtools index -@ 8 mapped/NA17-22-POLLENmapped.bam
samtools view -@ 8 -b -o mapped/NA17-23-POLLENmapped.bam  mapped/NA17-23-POLLENmapped.sam
samtools sort -@ 8 mapped/NA17-23-POLLENmapped.bam -o mapped/NA17-23-POLLENmapped.bam
samtools index -@ 8 mapped/NA17-23-POLLENmapped.bam
samtools view -@ 8 -b -o mapped/NA17-24-POLLENmapped.bam  mapped/NA17-24-POLLENmapped.sam
samtools sort -@ 8 mapped/NA17-24-POLLENmapped.bam -o mapped/NA17-24-POLLENmapped.bam
samtools index -@ 8 mapped/NA17-24-POLLENmapped.bam
rmmod SAMtools/1.14-GCC-8.3.0
ml UMI-tools/1.0.1-foss-2019b-Python-3.7.4
umi_tools group -I mapped/NA14-11-LEAFmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA14-11-LEAFDedup.bam
umi_tools group -I mapped/NA14-9-LEAFmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA14-9-LEAFDedup.bam
umi_tools group -I mapped/NA14-8-LEAFmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA14-8-LEAFDedup.bam
umi_tools group -I mapped/NA17-12-LEAFmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA17-12-LEAFDedup.bam
umi_tools group -I mapped/NA17-22-LEAFmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA17-22-LEAFDedup.bam
umi_tools group -I mapped/NA17-23-LEAFmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA17-23-LEAFDedup.bam
umi_tools group -I mapped/NA17-24-LEAFmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA17-24-LEAFDedup.bam
umi_tools group -I mapped/NA13-7-LEAFmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA13-7-LEAFDedup.bam
umi_tools group -I mapped/NA17-12-POLLENmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA17-12-POLLENDedup.bam
umi_tools group -I mapped/NA17-22-POLLENmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA17-22-POLLENDedup.bam
umi_tools group -I mapped/NA17-23-POLLENmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA17-23-POLLENDedup.bam
umi_tools group -I mapped/NA17-24-POLLENmapped.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA17-24-POLLENDedup.bam
rmmod UMI-tools/1.0.1-foss-2019b-Python-3.7.4
ml SAMtools/1.14-GCC-8.3.0
samtools view -f 64 -F 4 dedup/NA14-8-LEAFDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA14-8-LEAF.txt
samtools view -f 64 -F 4 dedup/NA14-9-LEAFDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA14-9-LEAF.txt
samtools view -f 64 -F 4 dedup/NA14-11-LEAFDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA14-11-LEAF.txt
samtools view -f 64 -F 4 dedup/NA17-12-LEAFDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA17-12-LEAF.txt
samtools view -f 64 -F 4 dedup/NA17-22-LEAFDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA17-22-LEAF.txt
samtools view -f 64 -F 4 dedup/NA17-23-LEAFDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA17-23-LEAF.txt
samtools view -f 64 -F 4 dedup/NA17-24-LEAFDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA17-24-LEAF.txt
samtools view -f 64 -F 4 dedup/NA13-7-LEAFDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA13-7-LEAF.txt
samtools view -f 64 -F 4 dedup/NA17-12-POLLENDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA17-12-POLLEN.txt
samtools view -f 64 -F 4 dedup/NA17-22-POLLENDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA17-22-POLLEN.txt
samtools view -f 64 -F 4 dedup/NA17-23-POLLENDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA17-23-POLLEN.txt
samtools view -f 64 -F 4 dedup/NA17-24-POLLENDedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7}' > outputnewawk/NA17-24-POLLEN.txt
