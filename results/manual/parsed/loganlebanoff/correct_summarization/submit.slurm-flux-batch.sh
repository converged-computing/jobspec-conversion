#!/bin/bash
#FLUX: --job-name=creamy-cherry-3416
#FLUX: -c=8
#FLUX: -t=356400
#FLUX: --priority=16

date
echo "Slurm nodes: $SLURM_JOB_NODELIST"
NUM_GPUS=`echo $GPU_DEVICE_ORDINAL | tr ',' '\n' | wc -l`
echo "You were assigned $NUM_GPUS gpu(s)"
nvidia-smi topo -m
echo
echo "${1}"
echo
${1}
echo
echo "Ending script..."
date
