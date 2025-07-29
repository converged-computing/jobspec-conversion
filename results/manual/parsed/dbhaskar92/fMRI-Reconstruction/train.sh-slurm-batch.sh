#!/bin/bash
#SBATCH --job-name=fmri-ode
#SBATCH --output=fmri-ode-%J.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=a100:1
#SBATCH --mem=64G
#SBATCH --time=15:00:00
#SBATCH --partition=gpu

module unload Python 
module load miniconda 
module load CUDA/11.1.1-GCC-10.2.0.lua CUDAcore/11.1.1.lua 
module load cuDNN/8.0.5.39-CUDA-11.1.1.lua 
conda activate pytorch_fmri  
python main.py
