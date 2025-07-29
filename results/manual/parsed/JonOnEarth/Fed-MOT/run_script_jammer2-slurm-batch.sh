#!/bin/bash
#SBATCH --job-name=gpu_ja
#SBATCH --output=myjob.%j.out
#SBATCH --error=myjob.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --mem=64GB
#SBATCH --time=08:00:00
#SBATCH --partition=gpu

source activate pytorch_env
python new_test_jammer2.py
