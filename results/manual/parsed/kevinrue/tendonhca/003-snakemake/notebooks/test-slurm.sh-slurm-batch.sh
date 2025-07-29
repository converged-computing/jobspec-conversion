#!/bin/bash
#SBATCH --output=%j_%x.out
#SBATCH --error=%j_%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10G
#SBATCH --time=01:00:00
#SBATCH --partition=gpu

cd /ceph/project/tendonhca/albrecht/003-snakemake/
eval "$(/project/sims-lab/albrecht/miniforge3/bin/conda shell.bash hook)" && conda activate base
conda activate envs/cell2location-nb
jupyter nbconvert --to notebook --execute ./hamstring-gpu.ipynb
