#!/bin/bash
#SBATCH --job-name=drqa
#SBATCH --output=slurm_%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=10GB
#SBATCH --time=20:00:00

module load python3/intel/3.6.3
module load pytorch/python3.6/0.3.0_4
module load cuda/8.0.44
module load cudnn/8.0v5.1
time src/python3 train.py --crop_size 88 --upscale_factor 4 --num_epochs 100
