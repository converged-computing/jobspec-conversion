#!/bin/bash
#SBATCH --account=account_name
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10GB
#SBATCH --time=05:00:00
#SBATCH --constraint=ntasks-per-node=128
#SBATCH --array=1-50

singularity exec -H /fp/projects01/account_name/abl_scm_perturbation_study/ docker/abl_scm_venv.sif python3 -u main.py $SLURM_ARRAY_TASK_ID 50
