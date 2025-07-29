#!/bin/bash
#SBATCH --job-name=multi-gpu-training
#SBATCH --account=True
#SBATCH --output=logs/multi-gpu-training_%A_%a.out
#SBATCH --error=logs/multi-gpu-training_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1
#SBATCH --nodelist=True

singularity exec --pwd $(pwd) --nv \
  -B /myovision:/mnt \
  image \
  bash -c "cd /mnt/myovision-sam && python3 inference.py"
