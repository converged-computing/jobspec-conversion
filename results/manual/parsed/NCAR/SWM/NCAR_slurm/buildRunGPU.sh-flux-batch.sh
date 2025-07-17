#!/bin/bash
#FLUX: --job-name=SWM
#FLUX: --queue=dav
#FLUX: -t=600
#FLUX: --urgency=16

module purge
module load pgi/20.4
module load cuda
module list
nvidia-smi
pgcc -O2 -acc -ta=tesla:cc70 -Minfo -Mnofma shallow_swap.acc.Tile.c wtime.c -o SWM_gpu
./SWM_gpu > results.gpu.Tile.$(date +%m%d%H%M%S).txt
