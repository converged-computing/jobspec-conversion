#!/bin/bash
#FLUX: --job-name=hairy-car-3065
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load nvidia-hpc-sdk
./async
