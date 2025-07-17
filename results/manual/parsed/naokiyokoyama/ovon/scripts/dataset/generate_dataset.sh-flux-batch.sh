#!/bin/bash
#FLUX: --job-name=ovon-dgen
#FLUX: -c=6
#FLUX: --queue=short
#FLUX: --urgency=16

export GLOG_minloglevel='2'
export HABITAT_SIM_LOG='quiet'
export MAGNUM_LOG='quiet'

export GLOG_minloglevel=2
export HABITAT_SIM_LOG=quiet
export MAGNUM_LOG=quiet
MAIN_ADDR=$(scontrol show hostnames "${SLURM_JOB_NODELIST}" | head -n 1)
export MAIN_ADDR
source /srv/flash1/rramrakhya3/miniconda3/etc/profile.d/conda.sh
conda deactivate
conda activate ovon
srun python ovon/dataset/objectnav_generator.py \
  --scene $scene \
  --split $split \
  --num-scenes $num_scenes \
  --tasks-per-gpu $num_tasks \
  --output-path $output_path \
  --start-poses-per-object $start_poses_per_object \
  --episodes-per-object $episodes_per_object \
  --disable-euc-geo-ratio-check
