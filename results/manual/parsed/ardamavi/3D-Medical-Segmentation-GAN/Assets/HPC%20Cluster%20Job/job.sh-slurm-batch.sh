#!/bin/bash
#SBATCH --job-name=3DSeg
#SBATCH --account=ai
#SBATCH --output=output.out
#SBATCH --mail-user=ardamavi2@gmail.com
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-00:00:00
#SBATCH --qos=ai
#SBATCH --constraint=ntasks-per-node=1

echo "Running Job"
python train.py
