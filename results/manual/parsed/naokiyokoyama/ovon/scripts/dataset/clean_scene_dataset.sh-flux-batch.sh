#!/bin/bash
#FLUX: --job-name=chocolate-lentil-4122
#FLUX: -c=7
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
echo "\n"
echo $scene_path
echo $(which python)
echo "ola"
srun python ovon/dataset/clean_episodes.py --path $scene_path --output-path $output_path
