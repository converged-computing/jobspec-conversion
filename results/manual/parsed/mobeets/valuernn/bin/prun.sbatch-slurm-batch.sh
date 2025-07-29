#!/bin/bash
#SBATCH --job-name=pytorch
#SBATCH --output=logs/pytorch_%A_%a.out
#SBATCH --error=logs/pytorch_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4000
#SBATCH --time=00:23:00

module load python/3.8.5-fasrc01
source activate pt38
srun -c 1 python quick_train.py newloss_"${SLURM_JOB_ID}"_"${SLURM_ARRAY_TASK_ID}" -k ${SLURM_ARRAY_TASK_ID} -t 1
