#!/bin/bash
#SBATCH --job-name=MNMG TensorFlow
#SBATCH --account=NAISS2024-22-219
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=alvis

module purge
module load TensorFlow/2.11.0-foss-2022a-CUDA-11.7.0
srun python mwms.py
