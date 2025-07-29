#!/bin/bash
#SBATCH --account=naiss2024-22-107
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=00:05:00
#SBATCH --exclusive

module load uppmax
module load python_ML_packages/3.9.5-gpu python/3.9.5 
source <path-to-to-your-virtual-environment>/Example-gpu/bin/activate
srun python pytorch_fitting_gpu.py
