#!/bin/bash
#FLUX: --job-name=wiki_en_02_colbert_index
#FLUX: -c=4
#FLUX: --queue=amdgpu
#FLUX: -t=86400
#FLUX: --urgency=16

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
export PYTHONPATH=.:$PYTHONPATH
CFG=cfg/index/wiki_en/index_cedmo_qacg_en_500tokens.config.py
python scripts/build_index.py $CFG
