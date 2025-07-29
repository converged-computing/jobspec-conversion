#!/bin/bash
#SBATCH --job-name=known
#SBATCH --account=Project_2002932
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=250G
#SBATCH --time=20:00:00

module load tensorflow/1.14.0
srun python3 train_stage_2.py
seff $SLURM_JOBID
