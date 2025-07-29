#!/bin/bash
#SBATCH --job-name=ppahs
#SBATCH --output=logs/slurm/out/stdout.%j.%N
#SBATCH --error=logs/slurm/err/stderr.%j.%N
#SBATCH --mail-user=paul.villanueva@usda.gov
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=16gb
#SBATCH --time=08:00:00

cd /project/fsepru/paul.villanueva/repos/ppahs
source /home/${USER}/.bashrc
source activate snakemake
date
time snakemake --use-conda --profile workflow/profile -p 
date
