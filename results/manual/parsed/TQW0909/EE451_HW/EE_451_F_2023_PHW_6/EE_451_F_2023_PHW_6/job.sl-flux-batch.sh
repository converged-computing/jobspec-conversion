#!/bin/bash
#FLUX --job-name=phat-car-7074
#FLUX -c=8
#FLUX --queue=gpu
#FLUX -t=3600
#FLUX --urgency=16

module purge
module load nvidia-hpc-sdk
./async
