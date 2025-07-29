#!/bin/bash
#SBATCH --job-name=resnet50_mixvpr
#SBATCH --output=jobfiles/logs/resnet50_mixvpr.log
#SBATCH --error=jobfiles/logs/resnet50_mixvpr.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:1
#SBATCH --mem=64G

python train.py --method resnet50_mixvpr --image_resolution 320 320
