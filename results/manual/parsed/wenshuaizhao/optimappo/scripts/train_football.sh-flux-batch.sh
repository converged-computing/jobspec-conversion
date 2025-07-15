#!/bin/bash
#FLUX: --job-name=football
#FLUX: -c=52
#FLUX: --queue=standard-g
#FLUX: -t=172800
#FLUX: --priority=16

SLURM_CPUS_PER_TASK=52
srun --cpus-per-task=$SLURM_CPUS_PER_TASK singularity run --cleanenv \
--rocm -B /scratch/project_462000215/mappo:/users/wenshuai/projects/mappo \
--env PYTHONPATH=/users/wenshuai/projects/mappo/prj_env/lib/python3.8/site-packages \
/scratch/project_462000215/docker/gfootball_latest.sif \
/bin/sh /users/wenshuai/projects/mappo/scripts/train_football_scripts/train_football_corner.sh
