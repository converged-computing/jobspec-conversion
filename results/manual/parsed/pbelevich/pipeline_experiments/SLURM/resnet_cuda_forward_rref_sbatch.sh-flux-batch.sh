#!/bin/bash
#FLUX: --job-name=resnet_cuda_forward_rref_sbatch
#FLUX: -N=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=q2
#FLUX: -t=3600
#FLUX: --priority=16

srun --label resnet_cuda_forward_rref.sh
