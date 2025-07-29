#!/bin/bash
#SBATCH --job-name=mcmc_runner
#SBATCH --account=ravt
#SBATCH --output=R-%x.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=05:30:00

module load Python
./venv/bin/python plot_maps_helper.py --states $1 --start $SLURM_ARRAY_TASK_ID
