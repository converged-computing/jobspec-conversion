#!/bin/bash
#SBATCH --output=deeplearn_%j.out
#SBATCH --error=deeplearn_%j.err
#SBATCH --mail-user=blaise.frederick@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=16:00:00

module load cuda91
python main.py
