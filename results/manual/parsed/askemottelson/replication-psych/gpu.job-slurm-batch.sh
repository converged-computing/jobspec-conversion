#!/bin/bash
#SBATCH --job-name=replication-gpu
#SBATCH --output=job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100:1
#SBATCH --time=03:00:00
#SBATCH --partition=red,brown

echo "Running on $(hostname):"
module load Anaconda3/
eval "$(conda shell.bash hook)"
conda activate reppsych
python go.py
