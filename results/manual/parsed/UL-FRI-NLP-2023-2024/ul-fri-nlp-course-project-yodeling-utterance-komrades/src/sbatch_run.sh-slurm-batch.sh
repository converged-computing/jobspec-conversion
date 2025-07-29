#!/bin/bash
#SBATCH --job-name=nlp-baseline
#SBATCH --output=baseline.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00
#SBATCH --partition=gpu

FILE=baseline.py
module load CUDA/12.1.1
srun singularity exec --nv ./containers/container-torch.sif python "baseline_run.py"
