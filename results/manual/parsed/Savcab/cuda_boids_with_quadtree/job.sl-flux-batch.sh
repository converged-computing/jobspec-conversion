#!/bin/bash
#FLUX: --job-name=astute-milkshake-5913
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load nvidia-hpc-sdk
module load gcc/8.3.0
./zorder
