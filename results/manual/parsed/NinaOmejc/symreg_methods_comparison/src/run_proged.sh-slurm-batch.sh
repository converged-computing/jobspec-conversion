#!/bin/bash
#SBATCH --job-name=mlj-p
#SBATCH --output=./symreg_methods_comparison/slurm/slurm_output_proged_%A_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=2-00:00:00
#SBATCH --array=0-1

echo "this is subjob" $(($1*1000 + $SLURM_ARRAY_TASK_ID))""
date
cd ./symreg_methods_comparison/
singularity exec symreg.sif python3.7 ./src/proged_system_identification_fullobs.py $(($1*1000 + $SLURM_ARRAY_TASK_ID))
echo "completed" 
