#!/bin/bash
#SBATCH --output=/scratch/am10485/slurm-logs/sort-%A_%a.out
#SBATCH --mail-user=am10485@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2GB
#SBATCH --time=00:30:00

echo PROJECT_DIR=${PROJECT_DIR}
cd ${PROJECT_DIR}
echo "Starting sorting . . . "
cd CPP/cmake-build-release
./SamplesSorter ${PROJECT_DIR}/plots/VorticityCorr.${M}.GPU.${RUN_ID}/Fdata.E.${T}.${SLURM_ARRAY_TASK_ID}.np
