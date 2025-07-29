#!/bin/bash
#SBATCH --job-name=regenScoresAreal
#SBATCH --account=share-ie-imf
#SBATCH --output=regenScoresAreal_%A_%a.out
#SBATCH --error=regenScoresAreal_%A_%a.err
#SBATCH --mail-user=john.paige@ntnu.no
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5000
#SBATCH --time=00:30:00
#SBATCH --partition=CPUQ

module load R/4.2.1-foss-2022a
module load GDAL/3.5.0-foss-2022a
Rscript --verbose regenScoresAreal.R ${SLURM_ARRAY_TASK_ID} > regenScoresAreal_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.Rout
