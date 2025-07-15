#!/bin/bash
#FLUX: --job-name=firre_proseq
#FLUX: -t=43200
#FLUX: --urgency=16

module load sra/2.8.0
module load bbmap/38.05
module load fastqc/0.11.8
module load hisat2/2.1.0
module load samtools/1.8
module load preseq/2.0.3
module load igvtools/2.3.75
module load mpich/3.2.1
module load bedtools/2.28.0
module load openmpi/1.6.4
module load gcc/7.1.0
source ~/anaconda3/etc/profile.d/conda.sh
conda activate rseqc
nextflow run main.nf -profile 'mm10' --workdir '/scratch/Shares/rinn/Michael/firre_timecourse/proseq/work' --genome_id 'mm10' --outdir '/scratch/Shares/rinn/Michael/firre_timecourse/proseq/results' --email mism6893@colorado.edu --fastqs '/scratch/Shares/rinn/Michael/firre_timecourse/proseq/fastq/*_{R1,R2}.fastq.gz' --saveBAM -resume
