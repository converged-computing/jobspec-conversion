#!/bin/bash
#FLUX: --job-name=imagenav
#FLUX: -c=10
#FLUX: --queue=short
#FLUX: --priority=16

export GLOG_minloglevel='2'
export HABITAT_SIM_LOG='quiet'
export MAGNUM_LOG='quiet'
export PYTHONPATH='/srv/flash1/rramrakhya3/spring_2023/habitat-sim/src_python/'

export GLOG_minloglevel=2
export HABITAT_SIM_LOG=quiet
export MAGNUM_LOG=quiet
MAIN_ADDR=$(scontrol show hostnames "${SLURM_JOB_NODELIST}" | head -n 1)
export MAIN_ADDR
source /srv/flash1/rramrakhya3/miniconda3/etc/profile.d/conda.sh
conda deactivate
conda activate ovon
export PYTHONPATH=/srv/flash1/rramrakhya3/spring_2023/habitat-sim/src_python/
TENSORBOARD_DIR="tb/imagenav/ver/resnetclip_avgattnpool/seed_1/"
CHECKPOINT_DIR="data/new_checkpoints/imagenav/ver/resnetclip_avgattnpool/seed_1/"
DATA_PATH="data/datasets/imagenav/hm3d/v1_stretch"
srun python -um ovon.run \
  --run-type train \
  --exp-config config/experiments/ver_imagenav.yaml \
  habitat_baselines.num_environments=32 \
  habitat_baselines.tensorboard_dir=${TENSORBOARD_DIR} \
  habitat_baselines.checkpoint_folder=${CHECKPOINT_DIR} \
  habitat.dataset.data_path=${DATA_PATH}/train/train.json.gz \
  habitat.simulator.type="OVONSim-v0" \
  habitat_baselines.log_interval=20 \
