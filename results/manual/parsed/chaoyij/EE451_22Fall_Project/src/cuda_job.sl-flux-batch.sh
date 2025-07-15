#!/bin/bash
#FLUX: --job-name=conspicuous-sundae-5980
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load nvidia-hpc-sdk
./gpu_miner 512 512 64
