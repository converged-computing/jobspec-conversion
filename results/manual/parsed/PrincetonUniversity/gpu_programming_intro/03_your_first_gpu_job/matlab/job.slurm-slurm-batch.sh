#!/bin/bash
#SBATCH --job-name=matlab-svd
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=4G
#SBATCH --time=00:05:00
#SBATCH --constraint=a100

module purge
module load matlab/R2022a
matlab -singleCompThread -nodisplay -nosplash -r svd
