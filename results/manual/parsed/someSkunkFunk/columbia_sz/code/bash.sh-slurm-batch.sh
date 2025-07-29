#!/bin/bash
#SBATCH --job-name=dum
#SBATCH --output=/dev/null
#SBATCH --mail-user=apalaci6@ur.rochester.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --partition=debug
#SBATCH --array=1-20

script_name='dummy' ##name of python script to run
output_dir="LOGS/$script_name"
mkdir -p $output_dir
exec > "$output_dir/${SLURM_JOB_ID}_${SLURM_ARRAY_TASK_ID}.log" 2>&1
date
hostname
source /scratch/apalaci6/miniconda3/bin/activate lalor0
python /scratch/apalaci6/columbia_sz/code/$script_name.py
