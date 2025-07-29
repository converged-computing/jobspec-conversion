#!/bin/bash
#SBATCH --job-name=lvd
#SBATCH --output=hpc/logs/lvd_%A.info
#SBATCH --error=hpc/logs/lvd_%A.info
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=64GB
#SBATCH --time=2-00:00:00

module load Singularity
module load CUDA/10.2.89
singularity exec -H /g/acvt/a1720858/sastvd --nv main.sif python -u sastvd/scripts/train_best.py
