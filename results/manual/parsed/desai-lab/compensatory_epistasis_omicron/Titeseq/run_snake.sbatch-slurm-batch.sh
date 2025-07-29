#!/bin/bash
#SBATCH --job-name=RBD_abecgivdhjx
#SBATCH --output=/n/desai_lab/users/tdupic/RBDabecgivdjhx_snakemake_%A_%a.out
#SBATCH --error=/n/desai_lab/users/tdupic/RBDabecgivdjhx_snakemake_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=64000
#SBATCH --time=00:12:00

module load python/3.7.7-fasrc01
source activate omicron
snakemake -j 48
