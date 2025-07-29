#!/bin/bash
#SBATCH --job-name=pfenet
#SBATCH --output=results/pfenet.out
#SBATCH --error=results/pfenet.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:V100:1
#SBATCH --mem=7000
#SBATCH --time=01:00:00

echo "Executing on $HOSTNAME"
date
module load nvidia/latest
module load cudnn/latest
CUDA_LAUNCH_BLOCKING=1 python3 test_pfenet.py
