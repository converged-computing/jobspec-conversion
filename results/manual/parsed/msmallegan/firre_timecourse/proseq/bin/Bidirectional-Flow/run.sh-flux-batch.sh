#!/bin/bash
#FLUX: --job-name=firre_bidir
#FLUX: --queue=long
#FLUX: -t=172800
#FLUX: --urgency=16

module load samtools/1.8
module load bedtools/2.28.0
module load openmpi/1.6.4
module load gcc/7.1.0
module load python/3.6.3
nextflow run main.nf -profile mm10 \
--bams "/scratch/Shares/rinn/Michael/firre_timecourse/proseq/results/mapped/bams/*.bam" \
--workdir /scratch/Shares/rinn/Michael/firre_timecourse/proseq/bidir_work/ \
--outdir /scratch/Shares/rinn/Michael/firre_timecourse/proseq/bidir_results \
--tfit \
--gene_count \
--savebidirs \
-resume
