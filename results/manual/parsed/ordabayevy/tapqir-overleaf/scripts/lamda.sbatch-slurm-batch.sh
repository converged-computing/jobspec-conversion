#!/bin/bash
#SBATCH --job-name=lamda
#SBATCH --output=simulations/lamda%a_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --array=0-4

lamdas=(0.01 0.05 0.15 0.5 1)
python scripts/cosmos_simulations.py \
  --gain 7 --pi 0.15 --height 3000 --proximity 0.2 \
  --lamda ${lamdas[${SLURM_ARRAY_TASK_ID}]} \
  --cuda \
  --path simulations/lamda${lamdas[${SLURM_ARRAY_TASK_ID}]}
