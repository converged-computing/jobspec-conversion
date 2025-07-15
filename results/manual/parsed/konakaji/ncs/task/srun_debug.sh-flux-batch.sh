#!/bin/bash
#FLUX: --job-name=carnivorous-toaster-3733
#FLUX: --gpus-per-task=1
#FLUX: --priority=16

srun -N 1 -n 4 shifter bash srun_exec.sh $1 --target nvidia-mgpu
