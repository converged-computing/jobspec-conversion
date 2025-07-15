#!/bin/bash
#FLUX: --job-name=w2
#FLUX: -n=4
#FLUX: --queue=mhigh,mlow
#FLUX: --priority=16

source /home/grupo06/venv/bin/activate
python src/main.py --exp_name resnet_kitti_${SLURM_JOB_ID} --config_file config/resnet_kitti.yml
