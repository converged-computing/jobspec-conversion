#!/bin/bash
#SBATCH --job-name=gym
#SBATCH --output=gym.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=batch

echo "---------------------------"
echo "Job started on" `date`
source ~/.bashrc ##source conda 
conda activate my_env
conda config --env --add channels conda-forge 
echo "---------------------------"
echo "Job ended on" `date`
