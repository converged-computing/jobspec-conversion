#!/bin/bash
#FLUX: --job-name=my-job
#FLUX: --queue=salvador
#FLUX: -t=4800
#FLUX: --priority=16

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
srun singularity run -B /ships19 -B /apollo -B $HOME/local-tbparse:$HOME/.local --nv $CONTAINER python extract_TB_data.py
