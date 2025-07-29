#!/bin/bash
#SBATCH --account=cusp
#SBATCH --output=scripts/sout/train_latest_2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gpus-per-task=1
#SBATCH --time=04:00:00
#SBATCH --constraint=gpu,ntasks-per-node=1

conda activate tfp
srun python scripts/train_ae.py
srun python scripts/train_flow.py 
srun python scripts/run_posterior_analysis.py
