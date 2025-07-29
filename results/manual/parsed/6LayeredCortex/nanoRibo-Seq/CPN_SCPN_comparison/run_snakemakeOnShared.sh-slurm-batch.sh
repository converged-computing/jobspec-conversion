#!/bin/bash
#SBATCH --output=snakemakeOnCluster_%j.out
#SBATCH --error=snakemakeOnCluster_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=15000
#SBATCH --time=1-00:00:00

module load Anaconda
source activate snakemake
./run_snakemake.sh live
