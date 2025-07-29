#!/bin/bash
#SBATCH --job-name=epoch7
#SBATCH --output=xepoch.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=50Gb
#SBATCH --time=08:00:00

source activate simclr1
python downstream_eval.py --downstream_task linear_eval -tm SSL -rd "runs/Apr30_12-16-03_d3100_e150" --comment "_e150_cfg_linear_ssl" &
sleep 60
python downstream_eval.py --downstream_task linear_eval -tm SSL -rd "runs/Apr30_12-15-02_d3100_e90" --comment "_e90_cfg_linear_ssl"
