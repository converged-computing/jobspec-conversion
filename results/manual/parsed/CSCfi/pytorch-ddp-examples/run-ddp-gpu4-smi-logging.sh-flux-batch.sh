#!/bin/bash
#FLUX: --job-name=grated-lizard-0825
#FLUX: -c=40
#FLUX: --queue=gputest
#FLUX: -t=900
#FLUX: --urgency=16

module purge
module load pytorch
nvidia-smi --query-gpu=index,temperature.gpu,utilization.gpu,utilization.memory --format=csv -l > gpu.log &
BG_PID=$!
srun torchrun --standalone --nnodes=1 --nproc_per_node=4 mnist_ddp.py --epochs=2
kill $BG_PID
