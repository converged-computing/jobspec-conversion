#!/bin/bash
#FLUX: --job-name=lovable-general-3917
#FLUX: --gpus-per-task=1
#FLUX: --urgency=16

srun -N 1 -n 4 shifter bash srun_exec.sh $1 --target nvidia-mgpu
