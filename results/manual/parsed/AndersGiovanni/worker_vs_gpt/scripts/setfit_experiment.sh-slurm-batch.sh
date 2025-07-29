#!/bin/bash
#SBATCH --job-name=experiments
#SBATCH --account=researchers
#SBATCH --output=run_outputs/trainer_setfit.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=gpu
#SBATCH --time=16:00:00

hostname
nvidia-smi
module load poetry
poetry shell
python -m src.worker_vs_gpt.setfit_classification
