#!/bin/bash
#FLUX --job-name=buttery-toaster-8338
#FLUX --gpus-per-task=1
#FLUX --queue=debug
#FLUX -t=600
#FLUX --urgency=16

srun -N 1 -n 4 shifter bash srun_exec.sh $1 --target nvidia-mgpu
