#!/bin/bash
#FLUX: --job-name=quirky-cinnamonbun-6416
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load nvidia-hpc-sdk
module load gcc/8.3.0
./zorder
