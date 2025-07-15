#!/bin/bash
#FLUX: --job-name=navigation-analysis-habitat
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --queue=priority
#FLUX: -t=259200
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/usr/lib/x86_64-linux-gnu/nvidia-opengl:${LD_LIBRARY_PATH}'
export GLOG_minloglevel='3'
export MAGNUM_LOG='quiet'
export MASTER_ADDR='$(srun --ntasks=1 hostname 2>&1 | tail -n1)'

echo ${PYTHONPATH}
echo "Using setup for Erik"
. /private/home/erikwijmans/miniconda3/etc/profile.d/conda.sh
conda deactivate
conda activate nav-analysis-base
BASE_EXP_DIR="/checkpoint/erikwijmans/exp-dir"
CURRENT_DATETIME="`date +%Y_%m_%d_%H_%M_%S`";
EXP_DIR="${BASE_EXP_DIR}/exp_habitat_api_navigation_analysis_datetime_${CURRENT_DATETIME}"
mkdir -p ${EXP_DIR}
ENV_NAME="gibson-challenge-mp3d-gibson-se-neXt25-depth"
ENV_NAME="gibson-2plus-resnet50-dpfrl-depth"
ENV_NAME="gibson-public-flee-pointnav-ftune-rgb-r${SLURM_ARRAY_TASK_ID}"
CHECKPOINT="data/checkpoints/transfer/${ENV_NAME}"
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/nvidia-opengl:${LD_LIBRARY_PATH}
export GLOG_minloglevel=3
export MAGNUM_LOG=quiet
export MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
printenv | grep SLURM
set -x
srun --kill-on-bad-exit=1 \
    python -u -m nav_analysis.train_ppo_distrib \
    --extra-confs \
    nav_analysis/configs/experiments/pointnav-rgb/se-resneXt50-rgb.yaml \
    nav_analysis/configs/experiments/transfer/flee_scratch.yaml \
    nav_analysis/configs/experiments/transfer/use_gibson_2plus_se_resneXt50_rgb_weights.yaml \
    nav_analysis/configs/experiments/transfer/use_policy_weights.yaml \
    --opts \
    "logging.log_file=${EXP_DIR}/log.txt" \
    "logging.checkpoint_folder=${CHECKPOINT}" \
    "logging.tensorboard_dir=runs/${ENV_NAME}"
