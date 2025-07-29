#!/bin/bash
#SBATCH --job-name=csfever_01_colbert_train
#SBATCH --output=../logs/csfever_01_colbert_train.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=128G
#SBATCH --time=1-00:00:00
#SBATCH --partition=amdgpu

export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION='python'
export PYTHONPATH='.:$PYTHONPATH'

echo running on: $SLURM_JOB_NODELIST
if [[ -z "${PROJECT_DIR}" ]]; then
    export PROJECT_DIR="$(dirname "$(pwd)")"
fi
if [ -f "${PROJECT_DIR}/init_environment_hflarge_amd.sh" ]; then
    source "${PROJECT_DIR}/init_environment_hflarge_amd.sh"
fi
cd ${PROJECT_DIR}
pwd
ml GCC/11.2.0
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
export PYTHONPATH=.:$PYTHONPATH
CFG=cfg/train/csfever/train_final.config.py
python scripts/train.py $CFG
