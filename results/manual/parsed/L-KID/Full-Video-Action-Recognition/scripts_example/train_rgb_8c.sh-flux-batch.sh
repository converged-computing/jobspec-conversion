#!/bin/bash
#FLUX: --job-name=cowy-lizard-1374
#FLUX: -c=2
#FLUX: --queue=general
#FLUX: -t=7200
#FLUX: --urgency=16

module use /opt/insy/modulefiles
module load cuda/10.0
srun python3 main.py movingmnist RGB \
     --arch resnet18 --num_segments 16 \
     --gd 20 --lr 0.001 --epochs 40 \
     --batch-size 16 -j 16 --dropout 0.8 --consensus_type=avg --eval-freq=1 \
     --shift --shift_div=8 --shift_place=blockres --npb
