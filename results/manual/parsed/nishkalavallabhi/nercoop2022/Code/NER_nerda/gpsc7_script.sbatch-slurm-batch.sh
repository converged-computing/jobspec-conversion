#!/bin/bash
#SBATCH --job-name=GPU-Mbert-Conll_nl-fine_tuning
#SBATCH --account=nrc_ict__gpu_a100
#SBATCH --output=%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-task=1
#SBATCH --mem=48G
#SBATCH --time=1-00:00:00
#SBATCH --qos=low

python sub_script.py
