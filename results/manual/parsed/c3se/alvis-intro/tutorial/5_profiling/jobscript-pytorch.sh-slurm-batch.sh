#!/bin/bash
#SBATCH --job-name=Profile PyTorch
#SBATCH --account=NAISS2024-22-219
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

module purge
module load PyTorch-bundle/1.12.1-foss-2022a-CUDA-11.7.0
module load matplotlib/3.5.2-foss-2022a
module load JupyterLab/3.5.0-GCCcore-11.3.0
jupyter lab
