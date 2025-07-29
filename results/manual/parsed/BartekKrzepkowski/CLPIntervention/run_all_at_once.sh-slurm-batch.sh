#!/bin/bash
#SBATCH --job-name=eff
#SBATCH --output=slurm_logs/slurm-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --gres=1
#SBATCH --mem=4G
#SBATCH --time=12:00:00

eval "$(conda shell.bash hook)"
conda activate clpi_env
source src/configs/env_variables.sh
WANDB__SERVICE_WAIT=300 python -m scripts.python_new.run_all_at_once model_name=mm_resnet dataset_name=mm_cifar10 lr=5e-1 wd=0.0 phase1=100 phase2=0 phase3=0 phase4=0
