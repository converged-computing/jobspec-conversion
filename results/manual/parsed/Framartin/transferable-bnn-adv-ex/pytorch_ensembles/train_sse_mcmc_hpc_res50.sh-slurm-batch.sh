#!/bin/bash
#SBATCH --job-name=TrainRes50
#SBATCH --output=log/run_train_csgld_resnet50_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=1
#SBATCH --time=17:00:00
#SBATCH --constraint=volta

command -v module >/dev/null 2>&1 && module load lang/Python
source ../venv/bin/activate
set -x
bash ./train_sse_mcmc.sh CIFAR10 resnet50 1 ../models ../data cSGLD
