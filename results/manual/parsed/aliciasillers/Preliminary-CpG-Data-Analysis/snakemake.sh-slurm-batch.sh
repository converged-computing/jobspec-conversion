#!/bin/bash
#SBATCH --job-name=snakemake
#SBATCH --output=snakemake.out
#SBATCH --error=snakemake.err
#SBATCH --mail-user=asillers@ucdavis.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=60G
#SBATCH --time=1-08:00:00

set -e                                                                     # Error if a single command fails
set -x                                                                     # Error if un-named variables calledset -x  >set -x
set -u
module load conda/latest
conda activate snakebio3
snakemake -j 20
