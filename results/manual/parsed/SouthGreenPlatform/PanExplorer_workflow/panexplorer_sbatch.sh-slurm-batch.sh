#!/bin/bash
#SBATCH --job-name=panexplorer
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=18
#SBATCH --mem=20G
#SBATCH --partition=supermem

export PANEX_PATH='$PWD'

module load singularity/4.0.1
export PANEX_PATH=$PWD
singularity exec $PANEX_PATH/singularity/panexplorer.sif snakemake --cores 1 -s Snakemake_files/Snakefile_pggb_heatmap_upset
