#!/bin/bash
#FLUX: --job-name=navigation-analysis-habitat-eval
#FLUX: -c=10
#FLUX: --queue=dev
#FLUX: -t=259200
#FLUX: --urgency=16

export PYTHONPATH='$(pwd)/habitat-api-navigation-analysis'
export LD_LIBRARY_PATH='/usr/lib/x86_64-linux-gnu/nvidia-opengl:${LD_LIBRARY_PATH}'

. $HOME/miniconda3/etc/profile.d/conda.sh
conda deactivate
conda activate nav-analysis-base
export PYTHONPATH=$(pwd)/habitat-api-navigation-analysis
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/nvidia-opengl:${LD_LIBRARY_PATH}
SIM_GPU_IDS="0"
PTH_GPU_ID="0"
SENSOR_TYPES="RGB_SENSOR"
CHECKPOINT_MODEL_DIR="data/checkpoints/gibson-public-explore-controller-512-rgb-r${SLURM_ARRAY_TASK_ID}"
CHECKPOINT_MODEL_DIR="data/checkpoints/gibson-public-flee-hrl-rgb-r5"
CHECKPOINT_MODEL_DIR="data/checkpoints/gibson-2plus-resnet18-frn-step-ramp-no-memory-depth"
CHECKPOINT_MODEL_DIR="data/checkpoints/mp3d-only-loopnav-stage-2-trained-state-blind"
CHECKPOINT_MODEL_DIR="data/checkpoints/mp3d-gibson-all-loopnav-stage-2-random-state-blind"
CHECKPOINT_MODEL_DIR="data/checkpoints/mp3d-gibson-all-loopnav-stage-2-random-state-no-inputs"
CHECKPOINT_MODEL_DIR="data/checkpoints/probes/mp3d-gibson-all-teleportnav-stage-2-zero-state-final-run_0_2-no-inputs/ckpt.124.pth"
CHECKPOINT_MODEL_DIR="data/checkpoints/probes/mp3d-gibson-all-loopnav-stage-2-trained-state-final-run_0_0-blind/ckpt.15.pth"
CHECKPOINT_MODEL_DIR="data/checkpoints/mp3d-gibson-all-loopnav-stage-1-v5-blind/ckpt.278.pth"
ENV_NAME=$(dirname ${CHECKPOINT_MODEL_DIR})
ENV_NAME=$(basename ${ENV_NAME})
NUM_PROCESSES=4
TASK_CONFIG="tasks/loopnav/gibson-public.loopnav.yaml"
NAV_TASK="pointnav"
if [ ${NAV_TASK} == "loopnav" ]
then
    echo "FIX ME"
    export LOG_FILE="$(pwd)/data/eval/eval.${ENV_NAME}.pointnav.log"
else
    export LOG_FILE="$(pwd)/data/eval/eval.${ENV_NAME}.pointnav.log"
    # export LOG_FILE="/private/home/akadian/navigation-analysis/navigation-analysis-habitat/evaluate.blind.loopnav.T_S.log"
    # export POSITIONS_FILE="/private/home/akadian/navigation-analysis/navigation-analysis-habitat/sts_episodes.pkl"
fi
rm ${LOG_FILE}
COUNT_TEST_EPISODES=1008
VIDEO=1
OUT_DIR_VIDEO="$(pwd)/data/eval/videos-with-data/${ENV_NAME}"
prm -r ${OUT_DIR_VIDEO}
mkdir -p ${OUT_DIR_VIDEO}
set -x
python -u -m nav_analysis.evaluate_ppo \
    --checkpoint-model-dir ${CHECKPOINT_MODEL_DIR} \
    --sim-gpu-ids ${SIM_GPU_IDS} \
    --pth-gpu-id ${PTH_GPU_ID} \
    --num-processes ${NUM_PROCESSES} \
    --log-file ${LOG_FILE} \
    --count-test-episodes ${COUNT_TEST_EPISODES} \
    --video ${VIDEO} \
    --out-dir-video ${OUT_DIR_VIDEO} \
    --eval-task-config ${TASK_CONFIG} \
    --nav-task ${NAV_TASK} \
    --tensorboard-dir "runs/${ENV_NAME}" \
    --nav-env-verbose 0 \
    --exit-immediately
    # --tensorboard-dir "runs/${ENV_NAME}" \
    # --max-memory-length ${i}
