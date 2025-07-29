#!/bin/bash
#SBATCH --job-name=lstm
#SBATCH --output=../Slurm/out%j.txt
#SBATCH --error=../Slurm/err%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=32000M
#SBATCH --time=00:11:59

nvidia-smi
conda env list
source activate cave
spack load cuda/gypzm3r
spack load cudnn
srun python3 ./run.py
