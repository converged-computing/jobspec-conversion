#!/bin/bash
#SBATCH --job-name=runValidation2
#SBATCH --account=share-ie-imf
#SBATCH --output=runValidation2_%A_%a.out
#SBATCH --error=runValidation2_%A_%a.err
#SBATCH --mail-user=john.paige@ntnu.no
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20000
#SBATCH --time=3-00:00:00
#SBATCH --partition=CPUQ

module load R/4.2.1-foss-2022a
module load GDAL/3.5.0-foss-2022a
Rscript --verbose runValidation2.R ${SLURM_ARRAY_TASK_ID} > runValidation2_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.Rout
