#!/bin/bash
#FLUX: --job-name=ddpg_Walker2D
#FLUX: --queue=long
#FLUX: -t=1080000
#FLUX: --urgency=16

export PATH='/home/yiming.peng/miniconda3/bin/:$PATH'

bash
export PATH=/home/yiming.peng/miniconda3/bin/:$PATH
source activate cmaes_baselines
python main.py --env-id Walker2DBulletEnv-v0 --seed $SLURM_ARRAY_TASK_ID
