#!/bin/bash
#FLUX: --job-name=anxious-parrot-8333
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load nvidia-hpc-sdk
module load gcc/8.3.0
./zorder
