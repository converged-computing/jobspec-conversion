#!/bin/bash
#SBATCH --job-name=epoch7
#SBATCH --output=xepoch.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=50Gb
#SBATCH --time=08:00:00

source activate simclr1
python downstream_eval.py --downstream_task linear_eval -tm SSL -rd "runs/May01_10-33-51_d3102_tmp175" --comment "_tmp175_cfg_linear_ssl" -e 400
