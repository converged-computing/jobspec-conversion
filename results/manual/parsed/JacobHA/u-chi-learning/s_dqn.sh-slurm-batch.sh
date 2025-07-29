#!/bin/bash
#SBATCH --job-name=logu-%A_%a
#SBATCH --output=logu-%A_%a.out
#SBATCH --error=logu-%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu

export WANDB_MODE='offline'

module load anaconda/3.9
source /home/$USER/.bashrc
conda activate u-chi-learning
export WANDB_MODE=offline
wandb offline
python experiments/dqn_baseline.py --n_runs=1 --proj=u-chi-learning
