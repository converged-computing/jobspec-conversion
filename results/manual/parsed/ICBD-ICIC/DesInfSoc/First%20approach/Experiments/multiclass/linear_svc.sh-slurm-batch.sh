#!/bin/bash
#SBATCH --job-name=itrust-linear_svc
#SBATCH --output=outputs/linear_svc-%A-%a.out
#SBATCH --error=errors/linear_svc-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=7-00:00:00
#SBATCH --array=31

source ../.experiments_env/bin/activate
srun python linear_svc.py ${SLURM_ARRAY_TASK_ID} context_ONLY-ACTION-SPREAD20_K3_H4_P12
