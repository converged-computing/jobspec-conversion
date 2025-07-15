#!/bin/bash
#FLUX: --job-name=ThunderCast
#FLUX: -N=2
#FLUX: -c=6
#FLUX: --queue=salvador
#FLUX: -t=85800
#FLUX: --urgency=16

nvidia-smi
hostname
squeue -q `hostname -s`
echo $CUDA_VISIBLE_DEVICES
echo "----"
group=$(dcgmi group -c allgpus --default)
if [ $? -eq 0 ]; then
groupid=$(echo $group | awk '{print $10}')
dcgmi stats -g $groupid -e
dcgmi stats -g $groupid -s $SLURM_JOB_ID
fi
CONTAINER=/home/shared/containers/pytorch_22.04-py3.sif
source /etc/profile
srun singularity run -B /ships19 -B /apollo -B $HOME/local-pytorch:$HOME/.local --nv $CONTAINER python torchlightning_main.py
