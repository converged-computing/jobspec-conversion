#!/bin/bash
#FLUX: --job-name=nlm_gpu
#FLUX: --queue=gpu
#FLUX: -t=600
#FLUX: --priority=16

module load gcc
module load cuda/10.1.243
make clean
make all
./nlm-serial
./nlm-cuda
./nlm-cuda-shared
make clean
