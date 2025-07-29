#!/bin/bash
#SBATCH --job-name=Salmon_Amygdala
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --mail-user=mjpete11@asu.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:00:00
#SBATCH --qos=normal

source activate salmon_environment
snakemake --snakefile Quantification.snakefile -j 20 --keep-target-files --rerun-incomplete --cluster "sbatch -n 8 -c 1 -t 5:00:00"
