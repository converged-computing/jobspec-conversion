#!/bin/bash
#FLUX: --job-name=dav_nav
#FLUX: -N=16
#FLUX: -c=10
#FLUX: --queue=learnlab,learnfair
#FLUX: -t=259200
#FLUX: --urgency=16

export MASTER_ADDR='$(srun --ntasks=1 hostname 2>&1 | tail -n1)'

export MASTER_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
set -x
srun python -u -m ss_baselines.av_nav.run \
    --exp-config ss_baselines/av_nav/config/audionav/mp3d/train_telephone/audiogoal_depth_ddppo.yaml  \
    --model-dir data/models/ss2/mp3d/dav_nav CONTINUOUS True
