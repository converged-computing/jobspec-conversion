#!/bin/bash
#FLUX --job-name=anxious-leopard-9669
#FLUX -c=8
#FLUX --queue=gpu
#FLUX -t=3600
#FLUX --urgency=16

module purge
module load nvidia-hpc-sdk
module load gcc/8.3.0
./zorder
