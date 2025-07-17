#!/bin/bash
#FLUX: --job-name=duel
#FLUX: -c=8
#FLUX: -t=21600
#FLUX: --urgency=16

module purge;
singularity exec --nv \
  --overlay /scratch/$USER/my_env/overlay-50G-10M.ext3:ro \
  /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif \
  /bin/bash -c "source /ext3/env.sh; python main.py --batch-size=64 --lr=0.00025 --discount-factor=0.99 --num-epochs=50 --memory-size=10000 --frame-repeat=12 --steps-per-epoch=2000 --epsilon-decay=0.9996 --model='duel_dqn' --checkpoint='duel'"
