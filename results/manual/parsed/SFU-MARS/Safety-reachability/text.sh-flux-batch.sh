#!/bin/bash
#FLUX: --job-name=fugly-house-2358
#FLUX: -c=6
#FLUX: --queue=long
#FLUX: -t=604800
#FLUX: --urgency=16

source ~/miniconda3/etc/profile.d/conda.sh
conda activate wpnr
hostname
echo $CUDA_AVAILABLE_DEVICES
srun python -u /local-scratch/tara/project/WayPtNav-reachability/executables/rgb/resnet50/rgb_waypoint_trainer.py --job-dir=/local-scratch/tara/project/WayPtNav-reachability/log/train --params=/local-scratch/tara/project/WayPtNav-reachability/params/rgb_trainer/sbpd/projected_grid/resnet50/rgb_waypoint_trainer_finetune_params.py --device=0
