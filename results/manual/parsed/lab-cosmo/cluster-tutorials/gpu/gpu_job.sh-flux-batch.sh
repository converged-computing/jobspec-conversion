#!/bin/bash
#FLUX: --job-name=gpu-info
#FLUX: --queue=gpu
#FLUX: -t=300
#FLUX: --priority=16

module purge
module load hpc-sdk
nvidia-smi > gpu.info
