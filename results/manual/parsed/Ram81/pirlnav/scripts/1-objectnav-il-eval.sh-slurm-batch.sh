#!/bin/bash
#FLUX: --job-name=pirlnav
#FLUX: -c=8
#FLUX: --queue=short
#FLUX: --urgency=16

export GLOG_minloglevel='2'
export MAGNUM_LOG='quiet'
export HABITAT_SIM_LOG='quiet'

source /srv/flash1/rramrakhya6/miniconda3/etc/profile.d/conda.sh
conda deactivate
conda activate pirlnav
export GLOG_minloglevel=2
export MAGNUM_LOG=quiet
export HABITAT_SIM_LOG=quiet
MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
export MASTER_ADDR
cd /srv/flash1/rramrakhya6/spring_2022/pirlnav
config="configs/experiments/il_objectnav.yaml"
DATA_PATH="data/datasets/objectnav/objectnav_hm3d/objectnav_hm3d_v1"
TENSORBOARD_DIR="tb/objectnav_il/ovrl_resnet50/seed_1/"
EVAL_CKPT_PATH_DIR=$1
mkdir -p $TENSORBOARD_DIR
set -x
echo "In ObjectNav IL eval"
srun python -u -m run \
--exp-config $config \
--run-type eval \
TENSORBOARD_DIR $TENSORBOARD_DIR \
EVAL_CKPT_PATH_DIR $EVAL_CKPT_PATH_DIR \
NUM_ENVIRONMENTS 20 \
RL.DDPPO.force_distributed True \
TASK_CONFIG.DATASET.SPLIT "val" \
EVAL.USE_CKPT_CONFIG False \
TASK_CONFIG.DATASET.DATA_PATH "$DATA_PATH/{split}/{split}.json.gz" \
