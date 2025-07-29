#!/bin/bash
#SBATCH --job-name=convnext_tiny_npt_adam.o
#SBATCH --output=convnext_tiny_npt_adam.o
#SBATCH --mail-user=fazeelath.mohammed@student.uni-siegen.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=10GB
#SBATCH --time=03:00:00

env_dir=/home/g050878/.conda/envs/augmixenv
echo "$env_dir"  "Environment Directory"
source ~/.bashrc
conda activate $env_dir 
conda env list
bash set_up.sh
python cifar.py -m convnext_tiny -lrsc CosineAnnealingLR -optim AdamW -s ./convnext_tiny/adam_npt
