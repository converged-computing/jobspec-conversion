#!/bin/bash
#SBATCH --job-name=fusion-data-pipeline
#SBATCH --account=project_2005083
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=03:00:00
#SBATCH --constraint=ntasks-per-node=1

module load python-data
srun python workflow.py
