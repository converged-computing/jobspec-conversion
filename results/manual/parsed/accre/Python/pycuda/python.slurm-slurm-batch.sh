#!/bin/bash
#SBATCH --account=accre_gpu
#SBATCH --output=python_job_slurm.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=1G
#SBATCH --time=00:10:00
#SBATCH --partition=maxwell

module load Anaconda3
source activate pycuda
module load CUDA
module load GCC
module load Boost
python < pycuda_eg.py
