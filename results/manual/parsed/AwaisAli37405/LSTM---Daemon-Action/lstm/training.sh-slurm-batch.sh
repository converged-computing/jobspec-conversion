#!/bin/bash
#SBATCH --job-name=special_permitl
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=10G
#SBATCH --time=8-00:00:00
#SBATCH --partition=amd
#SBATCH --array=0-2%1

module load any/python/3.8.3-conda
conda activate lstm-caise23
declare -a commands=(
"python ./dg_training.py -f PermitLog_filtered_preprocessed.csv -m lstm -e 50 -o rand_hpc" 
)
${commands[$SLURM_ARRAY_TASK_ID]}
