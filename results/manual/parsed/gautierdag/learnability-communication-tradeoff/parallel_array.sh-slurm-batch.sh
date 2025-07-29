#!/bin/bash
#SBATCH --job-name=proc-ce
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=1-00:00:00
#SBATCH --array=0-31

source ~/miniconda3/etc/profile.d/conda.sh
conda activate gp
python -u process_results.py $SLURM_ARRAY_TASK_ID
