#!/bin/bash
#SBATCH --job-name=rq1
#SBATCH --output=hpc/logs/rq1_%A.info
#SBATCH --error=hpc/logs/rq1_%A.info
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=32GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=batch

module load Singularity
module load CUDA/10.2.89
singularity exec -H /g/acvt/a1720858/sastvd --nv main.sif python -u sastvd/scripts/rq1.py
