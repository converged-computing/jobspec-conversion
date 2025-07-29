#!/bin/bash
#SBATCH --account=allocation_name
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50000
#SBATCH --time=05:00:00
#SBATCH --partition=standard

module purge
module load anaconda
source activate rnaseq
snakemake -p -j 8
