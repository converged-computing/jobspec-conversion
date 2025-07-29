#!/bin/bash
#SBATCH --job-name=runEd2AtRes
#SBATCH --account=share-ie-imf
#SBATCH --output=runEd2AtRes_%A_%a.out
#SBATCH --error=runEd2AtRes_%A_%a.err
#SBATCH --mail-user=john.paige@ntnu.no
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=10000
#SBATCH --time=3-00:00:00
#SBATCH --partition=CPUQ

module load R/4.2.1-foss-2022a
module load GDAL/3.5.0-foss-2022a
Rscript --verbose runEd2AtRes.R ${SLURM_ARRAY_TASK_ID} > runEd2AtRes_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.Rout
