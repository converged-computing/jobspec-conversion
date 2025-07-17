#!/bin/bash
#FLUX: --job-name=resnet_cuda_forward_tensor_sbatch
#FLUX: -N=4
#FLUX: --gpus-per-task=1
#FLUX: --queue=q2
#FLUX: -t=3600
#FLUX: --urgency=16

srun --label resnet_cuda_forward_tensor.sh
