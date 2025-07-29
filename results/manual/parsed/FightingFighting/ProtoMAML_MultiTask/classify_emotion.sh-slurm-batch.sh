#!/bin/bash
#SBATCH --job-name=ExampleJob
#SBATCH --output=slurm_output_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=48000M
#SBATCH --time=01:30:00
#SBATCH --partition=gpu_titanrtx_shared_course

cd $HOME/ATCS/group_assignment
source activate python385
srun python -u classify_emotion.py
