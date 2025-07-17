#!/bin/bash
#FLUX: --job-name=train
#FLUX: -N=4
#FLUX: -c=12
#FLUX: --queue=dc-gpu
#FLUX: -t=3600
#FLUX: --urgency=16

export CUDA_VISIBLE_DEVICES='0,1,2,3'
export PYTORCH_CUDA_ALLOC_CONF='max_split_size_mb:512'

echo 'SLURM JOB ID'
echo $SLURM_JOB_ID
echo 'Loading bashrc'
source $HOME/.bashrc
echo 'Starting training'
export CUDA_VISIBLE_DEVICES=0,1,2,3
export PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:512
source /p/project/vsk33/vanderweg/TopEC/topec_venv/bin/activate
srun python -u train.py --config-name train experiment=$1
