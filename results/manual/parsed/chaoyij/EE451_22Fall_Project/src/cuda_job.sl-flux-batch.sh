#!/bin/bash
#FLUX: --job-name=sticky-motorcycle-8348
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=3600
#FLUX: --priority=16

module purge
module load nvidia-hpc-sdk
./gpu_miner 512 512 64
