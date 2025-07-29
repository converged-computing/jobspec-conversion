#!/bin/bash
#SBATCH --job-name=seed
#SBATCH --output=simulations/seed%a_%A.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --array=0-16

python scripts/cosmos_simulations.py \
  --seed ${SLURM_ARRAY_TASK_ID} \
  --cuda \
  --path simulations/seed${SLURM_ARRAY_TASK_ID}
