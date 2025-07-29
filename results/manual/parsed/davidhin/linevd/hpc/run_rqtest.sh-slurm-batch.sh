#!/bin/bash
#SBATCH --job-name=rqT
#SBATCH --output=hpc/logs/rqT_%A.info
#SBATCH --error=hpc/logs/rqT_%A.info
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=64GB
#SBATCH --time=2-00:00:00

module load Singularity
module load CUDA/10.2.89
singularity exec -H /g/acvt/a1720858/sastvd --nv main.sif python -u sastvd/scripts/rqtest.py
