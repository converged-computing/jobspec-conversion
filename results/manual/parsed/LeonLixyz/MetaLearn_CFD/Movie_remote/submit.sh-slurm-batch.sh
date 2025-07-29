#!/bin/bash
#SBATCH --job-name=Movie_experiments_name
#SBATCH --account=theory
#SBATCH --output=slurm/slurm_%x_%a_%A.out
#SBATCH --error=slurm/slurm_%x_%a_%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16gb
#SBATCH --time=5-00:00:00
#SBATCH --array=0-6%12

[[ ! -d slurm ]] && mkdir slurm
experiment_name=$(sed -n "${SLURM_ARRAY_TASK_ID}p" experiments.txt)
echo Queueing experiment $experiment_name
source ~/.bashrc
conda activate pytorch_env
srun python Main.py $experiment_name
conda deactivate
