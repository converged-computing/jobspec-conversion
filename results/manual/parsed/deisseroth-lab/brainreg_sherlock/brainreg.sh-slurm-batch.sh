#!/bin/bash
#SBATCH --output=./logs/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=8GB
#SBATCH --time=08:00:00

ml python/3.9 gcc
source ${GROUP_HOME}/projects/registration/brainreg/venv/bin/activate
echo "======"
echo "Params"
echo "$@"
echo "======"
brainreg "$@"
