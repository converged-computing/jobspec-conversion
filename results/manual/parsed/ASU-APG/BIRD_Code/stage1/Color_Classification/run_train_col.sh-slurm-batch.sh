#!/bin/bash
#SBATCH --output=./slurm/slurm.%j.out
#SBATCH --error=./slurm/slurm.%j.err
#SBATCH --mail-user=tgokhale@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=2-00:12:00

module load tensorflow/1.8-agave-gpu
cd /home/tgokhale/work/code/Color_Classification
python3 train.py --checkpoint_path ./checkpoint/lr05_b4_alpha1_beta5 --lr 0.05 --batch_size 4 --alpha 0.1 --beta 0.5
