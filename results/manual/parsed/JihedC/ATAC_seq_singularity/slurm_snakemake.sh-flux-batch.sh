#!/bin/bash
#FLUX: --job-name=ATAC_snakemake
#FLUX: --priority=16

module purge
module load genomics/ngs/samtools/1.11/gcc-8.3.1
module load genomics/ngs/aligners/bowtie2/2.4.2/gcc-8.3.1
module load container/singularity/3.10.0/gcc.8.5.0
module load tools/miniconda/python3.8/4.8.5
echo Start time : `date`
snakemake -p \
        --snakefile Snakefile \
        --latency-wait 60 \
        --wait-for-files \
        --rerun-incomplete \
        --use-singularity \
        --use-conda \
        --cluster "sbatch --parsable --partition=all --mem=36g --ntasks=1 --cpus-per-task=8 --time=24:00:00 --hint=multithread" \
 	--cluster-status "./slurm-cluster-status.py" \
	--jobs 30
echo End time : `date`
