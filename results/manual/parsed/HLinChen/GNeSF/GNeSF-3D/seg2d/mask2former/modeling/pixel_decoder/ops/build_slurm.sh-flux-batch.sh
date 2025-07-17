#!/bin/bash
#FLUX: --job-name=train_atlas
#FLUX: -c=8
#FLUX: --queue=medium
#FLUX: -t=10800
#FLUX: --urgency=16

export CUDA_HOME='/usr/local/cuda # /usr/local/cuda-10.2'

echo "$state Start"
echo Time is `date`
echo "Directory is ${PWD}"
echo "This job runs on the following nodes: ${SLURM_JOB_NODELIST}"
nvidia-smi
export CUDA_HOME=/usr/local/cuda # /usr/local/cuda-10.2
sh make.sh
