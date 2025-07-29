#!/bin/bash
#SBATCH --job-name=jobname
#SBATCH --output=jobname-out.o%j
#SBATCH --error=jobname-error.e%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32000
#SBATCH --time=1-00:00:00
#SBATCH --partition=private-kalousis-gpu

srun singularity exec --nv pytorch_geo.sif python3 ~/CGAN-graph-generic/main.py --data_path=/home/users/b/boget3/data/
