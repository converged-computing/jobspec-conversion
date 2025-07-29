#!/bin/bash
#SBATCH --job-name=dl4
#SBATCH --output=xepoch.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --mem=60Gb
#SBATCH --time=1-00:00:00

source activate simclr1
python downstream_eval.py --downstream_task linear_eval -tm SSL -rd "runs/Apr29_23-17-12_d1008_cifar10_resnet18" --comment "_resnet18_cifar10_cfg_linear_ssl" 
