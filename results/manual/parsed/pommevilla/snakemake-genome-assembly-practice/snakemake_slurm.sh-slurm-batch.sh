#!/bin/bash
#SBATCH --job-name=snakemake_run
#SBATCH --output=logs/slurm/out/stdout.%j.%N
#SBATCH --error=logs/slurm/err/stderr.%j.%N
#SBATCH --mail-user=paul.villanueva@usda.gov
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=100gb
#SBATCH --time=2-00:00:00

cd /project/fsepru/paul.villanueva/repos/snakemake-genome-assembly-practice
source /home/${USER}/.bashrc
source activate snakemake
date
time snakemake --use-conda --profile slurm -p
date
