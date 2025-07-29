#!/bin/bash
#FLUX: --job-name=navigation-analysis-habitat
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --queue=learnlab,learnfair
#FLUX: -t=259200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/usr/lib/x86_64-linux-gnu/nvidia-opengl:${LD_LIBRARY_PATH}'
export GLOG_minloglevel='3'
export MAGNUM_LOG='quiet'

echo ${PYTHONPATH}
echo "Using setup for Erik"
. /private/home/erikwijmans/miniconda3/etc/profile.d/conda.sh
conda deactivate
conda activate nav-analysis-base
SCENES=(RPmz2sHmrrY Scioto jtcxE69GiFV)
SCENES=(Scioto jtcxE69GiFV)
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/nvidia-opengl:${LD_LIBRARY_PATH}
export GLOG_minloglevel=3
export MAGNUM_LOG=quiet
unset NCCL_SOCKET_IFNAME GLOO_SOCKET_IFNAME
SIM_GPU_IDS="0"
PTH_GPU_ID="0"
BASE_EXP_DIR="/checkpoint/erikwijmans/exp-dir"
CURRENT_DATETIME="`date +%Y_%m_%d_%H_%M_%S`";
EXP_DIR="${BASE_EXP_DIR}/exp_habitat_api_navigation_analysis_datetime_${CURRENT_DATETIME}"
mkdir -p ${EXP_DIR}
for SCENE in "${SCENES[@]}"
do
    ENV_NAME="mdp/${SCENE}"
    CHECKPOINT="data/checkpoints/${ENV_NAME}"
    TASK_CONFIG="tasks/mdp/pomdp.pointnav.yaml"
    OUT_DIR_VIDEO="${CHECKPOINT}/eval/videos-pomdp"
    python -u -m nav_analysis.evaluate_ppo \
        --checkpoint-model-dir data/checkpoints/demo_probe.pth \
        --sim-gpu-ids ${SIM_GPU_IDS} \
        --pth-gpu-id ${PTH_GPU_ID} \
        --num-processes 1 \
        --log-file "${CHECKPOINT}/eval.log" \
        --count-test-episodes 100 \
        --video 1 \
        --out-dir-video ${OUT_DIR_VIDEO} \
        --eval-task-config ${TASK_CONFIG} \
        --nav-task "teleportnav" \
        --tensorboard-dir "runs/${ENV_NAME}" \
        --nav-env-verbose 0 \
        --split "${SCENE}" \
        --exit-immediately
    OUT_DIR_VIDEO="${CHECKPOINT}/eval/videos-mdp"
    TASK_CONFIG="tasks/mdp/mdp.pointnav.yaml"
    python -u -m nav_analysis.evaluate_ppo \
        --checkpoint-model-dir ${CHECKPOINT}/ckpt.165.pth \
        --sim-gpu-ids ${SIM_GPU_IDS} \
        --pth-gpu-id ${PTH_GPU_ID} \
        --num-processes 1 \
        --log-file "${CHECKPOINT}/eval.log" \
        --count-test-episodes 100 \
        --video 1 \
        --out-dir-video ${OUT_DIR_VIDEO} \
        --eval-task-config ${TASK_CONFIG} \
        --nav-task "pointnav" \
        --tensorboard-dir "runs/${ENV_NAME}" \
        --nav-env-verbose 0 \
        --split "${SCENE}" \
        --exit-immediately
done
