#!/bin/bash
#SBATCH --job-name=run2DatasetsTest
#SBATCH --account=share-ie-imf
#SBATCH --output=run2DatasetsTest_%A_%a.out
#SBATCH --error=run2DatasetsTest_%A_%a.err
#SBATCH --mail-user=john.paige@ntnu.no
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=3000
#SBATCH --time=00:01:00

module load R/4.2.1-foss-2022a
module load GDAL/3.5.0-foss-2022a
Rscript --verbose run2DatasetsTest.R ${SLURM_ARRAY_TASK_ID} > run2DatasetsTest_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.Rout
