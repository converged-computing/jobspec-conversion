#!/bin/bash
#SBATCH --job-name=post_processing
#SBATCH --output=outerr_pp.log
#SBATCH --error=outerr_pp.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=2-00:00:00

module load python/3.10.12
module load cuda
module load nccl
pipenv run python functions/post_processing.py
