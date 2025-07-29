#!/bin/bash
#SBATCH --account=courses
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=500M
#SBATCH --time=00:05:00
#SBATCH --partition=courses-gpu
#SBATCH --constraint=ntasks-per-node=1

module purge
module load gcc/11.3.0 cmake/3.26.3 openmpi/4.1.5
srun ../build/quicksort-gpu
