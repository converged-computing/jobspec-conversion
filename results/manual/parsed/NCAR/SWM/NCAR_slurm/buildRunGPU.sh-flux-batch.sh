#!/bin/bash
#FLUX: --job-name=swampy-cinnamonbun-5769
#FLUX: --urgency=16

module purge
module load pgi/20.4
module load cuda
module list
nvidia-smi
pgcc -O2 -acc -ta=tesla:cc70 -Minfo -Mnofma shallow_swap.acc.Tile.c wtime.c -o SWM_gpu
./SWM_gpu > results.gpu.Tile.$(date +%m%d%H%M%S).txt
