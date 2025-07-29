#!/bin/bash
#SBATCH --job-name=snakemake_rnaseq
#SBATCH --output=parallel_%j.log
#SBATCH --mail-user=m.galland@uva.nl
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --mem=8G
#SBATCH --time=1-00:00:00

source activate rnaseq
srun snakemake -j $SLURM_CPUS_PER_TASK
