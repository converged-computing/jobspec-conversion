#!/bin/bash
#SBATCH --job-name=medical
#SBATCH --output=medical%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --mem=64G
#SBATCH --time=6-23:00:00
#SBATCH --qos=batch

pyenv activate moose_env
module load cuda
CUDA_VISIBLE_DEVICES=0 python /misc/no_backups/s1449/Medical-Images-Synthesis/utils/miou_folder/moose_segment.py
