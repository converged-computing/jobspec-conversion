#!/bin/bash
#SBATCH --job-name=test
#SBATCH --output=./%N.%j.%x.out
#SBATCH --error=./%N.%j.%x.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:2
#SBATCH --mem=12G
#SBATCH --time=00:10:00

env
echo "--- *** --- *** ---"
nvidia-smi
