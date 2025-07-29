#!/bin/bash
#SBATCH --job-name=3feature_files
#SBATCH --error=feature_files%j.err
#SBATCH --mail-user=manuela.koepfli@wsl.ch
#SBATCH --mail-type=SUBMIT,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:06:00
#SBATCH --qos=normal
#SBATCH --array=123,135,136,137,234,199,207,208,223,233

python comp_con_attributes_array3.py "${SLURM_ARRAY_TASK_ID}"
