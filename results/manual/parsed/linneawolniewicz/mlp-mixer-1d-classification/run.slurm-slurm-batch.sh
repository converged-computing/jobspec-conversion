#!/bin/bash
#SBATCH --job-name=optuna_mlp_mixer
#SBATCH --account=koa
#SBATCH --output=logs/slurm_output/job-%A.out
#SBATCH --mail-user=linneamw@hawaii.edu
#SBATCH --mail-type=START,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=156gb
#SBATCH --time=14-00:00:00

source ~/profiles/auto.profile
source activate pytorch
python hyperparameter_tuning.py
