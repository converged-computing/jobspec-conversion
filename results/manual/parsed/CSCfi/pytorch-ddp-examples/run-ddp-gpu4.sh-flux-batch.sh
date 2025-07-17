#!/bin/bash
#FLUX: --job-name=dirty-punk-6133
#FLUX: -c=40
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load pytorch
srun torchrun --standalone --nnodes=1 --nproc_per_node=4 mnist_ddp.py --epochs=100
