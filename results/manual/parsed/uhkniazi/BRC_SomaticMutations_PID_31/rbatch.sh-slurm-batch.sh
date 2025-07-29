#!/bin/bash
#SBATCH --job-name=rbatch_1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=40000MB
#SBATCH --time=2-00:00:00
#SBATCH --array=1-73

number=$SLURM_ARRAY_TASK_ID
module load r/4.1.1-gcc-9.4.0-withx-rmath-standalone-python-3.8.12
Rscript 08_shearwaterML.R $number
