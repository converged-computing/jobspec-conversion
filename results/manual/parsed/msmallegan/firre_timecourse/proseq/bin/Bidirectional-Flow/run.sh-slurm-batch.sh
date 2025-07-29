#!/bin/bash
#SBATCH --job-name=firre_bidir
#SBATCH --output=nextflow.%j.out
#SBATCH --error=nextflow.%j.err
#SBATCH --mail-user=mism6893@colorado.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8gb
#SBATCH --time=2-00:00:00

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
