#!/bin/bash
#SBATCH --job-name=gt3x_processing
#SBATCH --output=/ocean/projects/med220004p/shared/data_sandbox/ggir_proc/group1/logs/job_%A_%a.out
#SBATCH --error=/ocean/projects/med220004p/shared/data_sandbox/ggir_proc/group1/logs/job_%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00
#SBATCH --partition=RM-shared
#SBATCH --constraint=ntasks-per-node=10
#SBATCH --array=1-100%50

set -x
SINGULARITY_CONTAINER=/ocean/projects/med220004p/shared/data_raw/backup_onprem/adam/ggir_test_ggir_test2_v2.sif 
BASE_DIR=/ocean/projects/med220004p/shared/data_sandbox/ggir_proc/group1/
DIR_TO_PROCESS="${BASE_DIR}/subdir_${SLURM_ARRAY_TASK_ID}"
singularity run --bind ${DIR_TO_PROCESS}:/data --bind ${DIR_TO_PROCESS}:/output ${SINGULARITY_CONTAINER} 
