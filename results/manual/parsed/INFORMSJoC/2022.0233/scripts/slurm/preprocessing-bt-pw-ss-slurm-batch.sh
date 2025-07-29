#!/bin/bash
#SBATCH --output=/dev/null
#SBATCH --error=/dev/null
#SBATCH --mail-user=btasseff@lanl.gov
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH: --exclusive

export OMP_NUM_THREADS='1'

source .profile
EXPERIMENT_CSV_PATH="data/experiments/preprocessing/BT-PW-SS.csv"
LINE_NUMBER=${SLURM_ARRAY_TASK_ID}
LINE_STRING=$(sed "${LINE_NUMBER}q;d" ${EXPERIMENT_CSV_PATH})
IFS=',' read -a PARAMETER_ARRAY <<< "${LINE_STRING}"
INSTANCE_PATH=${PARAMETER_ARRAY[0]}
RESULT_PATH=${PARAMETER_ARRAY[1]}
LOG_PATH=${PARAMETER_ARRAY[2]}
export OMP_NUM_THREADS=1
SYSIMAGE_PATH="scripts/precompilation/WaterModels.so"
julia \
    -J${SYSIMAGE_PATH} \
    --threads 128 \
    scripts/execution/preprocessing-bt-pw-ss.jl \
    --input_path ${INSTANCE_PATH} \
    --output_path ${RESULT_PATH} \
    --time_limit 28800.0 \
    &> ${LOG_PATH}
