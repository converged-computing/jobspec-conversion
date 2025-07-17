#!/bin/bash
#FLUX: --job-name=enfever_01_colbert_train
#FLUX: -c=4
#FLUX: --queue=amdgpu
#FLUX: -t=86400
#FLUX: --urgency=16

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
CFG=cfg/train/enfever/train_final.config.py
python scripts/train.py $CFG
