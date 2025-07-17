#!/bin/bash
#FLUX: --job-name=AMPHIBIOUS GAZE IMPROVEMENT
#FLUX: --queue=iris-hi
#FLUX: -t=259200
#FLUX: --urgency=16

export ENV_NAME='${1}'
export SEED='${2}'
export CAM_NAME='${3}'
export EMB_NAME='${4}'
export LOAD_PATH='${5}'
export NUM_DEMOS='10'
export PYTHONPATH='/iris/u/kayburns/new_arch/Intriguing-Properties-of-Vision-Transformers/'

export ENV_NAME=${1}
export SEED=${2}
export CAM_NAME=${3}
export EMB_NAME=${4}
export LOAD_PATH=${5}
export NUM_DEMOS=10
if [[ "${1}" == *"v2"* ]]; then
    echo "Using proprio=4 for Meta-World environment."
    export PROPRIO=4
else
    echo "Using proprio=9 for FrankaKitchen environment."
    export PROPRIO=9
fi
export PYTHONPATH='/iris/u/kayburns/new_arch/Intriguing-Properties-of-Vision-Transformers/'
source /sailhome/kayburns/.bashrc
conda activate py3.8_torch1.10.1
cd /iris/u/kayburns/new_arch/r3m/evaluation/
python r3meval/core/hydra_launcher.py hydra/launcher=local hydra/output=local \
    env=${ENV_NAME} camera=${CAM_NAME} pixel_based=true \
    embedding=${EMB_NAME} num_demos=${NUM_DEMOS} env_kwargs.load_path=${LOAD_PATH} \
    bc_kwargs.finetune=false proprio=${PROPRIO} job_name=try_r3m seed=${SEED}
