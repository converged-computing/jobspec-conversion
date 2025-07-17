#!/bin/bash
#FLUX: --job-name=fastptotxt
#FLUX: -n=8
#FLUX: --queue=batch
#FLUX: -t=36000
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
ml fastp/0.23.2
fastp -i rawdata/NA14-8R1.fastq.gz -o processed/NA14-8R1A.fastq.gz -f 23 -A -G -Q -L
fastp -i rawdata/NA14-9R1.fastq.gz -o processed/NA14-9R1A.fastq.gz -f 23 -A -G -Q -L
fastp -i rawdata/NA14-11R1.fastq.gz -o processed/NA14-11R1A.fastq.gz -f 23 -A -G -Q -L
fastp -w 8 -i processed/NA14-8R1A.fastq.gz -I rawdata/NA14-8R2.fastq.gz -o processed/NA14-8R1B.fastq.gz -O processed/NA14-8R2B.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h fastp.html -A -G -Q -L
fastp -w 8 -i processed/NA14-9R1A.fastq.gz -I rawdata/NA14-9R2.fastq.gz -o processed/NA14-9R1B.fastq.gz -O processed/NA14-9R2B.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h fastp.html -A -G -Q -L
fastp -w 8 -i processed/NA14-11R1A.fastq.gz -I rawdata/NA14-11R2.fastq.gz -o processed/NA14-11R1B.fastq.gz -O processed/NA14-11R2B.fastq.gz -U --umi_loc read1 --umi_len 6 --umi_prefix TIR -h fastp.html -A -G -Q -L
fastp -w 8 -i processed/NA14-8R1B.fastq.gz -I processed/NA14-8R2B.fastq.gz -o filtered/NA14-8R1.fastq.gz -O filtered/NA14-8R2.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/remapdir/adapter.fa
fastp -w 8 -i processed/NA14-9R1B.fastq.gz -I processed/NA14-9R2B.fastq.gz -o filtered/NA14-9R1.fastq.gz -O filtered/NA14-9R2.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/remapdir/adapter.fa
fastp -w 8 -i processed/NA14-11R1B.fastq.gz -I processed/NA14-11R2B.fastq.gz -o filtered/NA14-11R1.fastq.gz -O filtered/NA14-11R2.fastq.gz -U --umi_loc read2 --umi_len 8 --umi_skip 11 --umi_prefix UMI --length_required 40 --trim_poly_x --cut_tail --adapter_fasta /scratch/jts34805/remapdir/adapter.fa
rmmod fastp/0.23.2
ml Bowtie2
bowtie2 --threads 8 -x /scratch/jts34805/remapdir/W22Build/W22chrscaff --phred33 -X 1000 --no-mixed --no-discordant -1 filtered/NA14-8R1.fastq.gz -2 filtered/NA14-8R2.fastq.gz -S mapped/NA14-8.sam
bowtie2 --threads 8 -x /scratch/jts34805/remapdir/W22Build/W22chrscaff --phred33 -X 1000 --no-mixed --no-discordant -1 filtered/NA14-9R1.fastq.gz -2 filtered/NA14-9R2.fastq.gz -S mapped/NA14-9.sam
bowtie2 --threads 8 -x /scratch/jts34805/remapdir/W22Build/W22chrscaff --phred33 -X 1000 --no-mixed --no-discordant -1 filtered/NA14-11R1.fastq.gz -2 filtered/NA14-11R2.fastq.gz -S mapped/NA14-11.sam
rmmod Bowtie2
ml SAMtools/1.14-GCC-8.3.0
samtools view -@ 8 -b -o mapped/NA14-8.bam  mapped/NA14-8.sam
samtools sort -@ 8 mapped/NA14-8.bam -o mapped/NA14-8.bam
samtools index -@ 8 mapped/NA14-8.bam
samtools view -@ 8 -b -o mapped/NA14-9.bam  mapped/NA14-9.sam
samtools sort -@ 8 mapped/NA14-9.bam -o mapped/NA14-9.bam
samtools index -@ 8 mapped/NA14-9.bam
samtools view -@ 8 -b -o mapped/NA14-11.bam  mapped/NA14-11.sam
samtools sort -@ 8 mapped/NA14-11.bam -o mapped/NA14-11.bam
samtools index -@ 8 mapped/NA14-11.bam
rmmod SAMtools/1.14-GCC-8.3.0
ml UMI-tools/1.0.1-foss-2019b-Python-3.7.4
umi_tools group -I mapped/NA14-8.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA14-8.Dedup.bam
umi_tools group -I mapped/NA14-9.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA14-9.Dedup.bam
umi_tools group -I mapped/NA14-11.bam --paired --chimeric-pairs discard --unpaired-reads discard --output-bam -S dedup/NA14-11.Dedup.bam
rmmod UMI-tools/1.0.1-foss-2019b-Python-3.7.4
ml SAMtools/1.14-GCC-8.3.0
samtools view -f 64 -F 4 dedup/NA14-8.Dedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7, $8}' > txtfiles/NA14-8LEAF.txt
samtools view -f 64 -F 4 dedup/NA14-9.Dedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7, $8}' > txtfiles/NA14-9LEAF.txt
samtools view -f 64 -F 4 dedup/NA14-11.Dedup.bam | awk -F" " '{sub(/.*TIR_/,"",$1); sub(/BX:Z:/,"",$(NF)); print $3, $4, $9, $1, $(NF), $5, length($10), $10, $8}' | awk '{sub(/:UMI_.*/,"",$4); print $1, $2, $9, $3, $4, $5, $6, $7, $8}' > txtfiles/NA14-11LEAF.txt
