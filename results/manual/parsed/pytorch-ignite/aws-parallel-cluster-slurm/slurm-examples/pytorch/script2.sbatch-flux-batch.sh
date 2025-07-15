#!/bin/bash
#FLUX: --job-name=script2
#FLUX: --queue=cpu-compute-spot
#FLUX: -t=300
#FLUX: --priority=16

date;hostname;pwd
source activate test
conda list | grep pytorch
echo "SLURM_JOB_ID: $SLURM_JOB_ID"
echo "SLURM_NNODES: $SLURM_NNODES"
echo "SLURM_NTASKS: $SLURM_NTASKS"
echo "SLURM_NTASKS_PER_NODE: $SLURM_NTASKS_PER_NODE"
echo "SLURM_LOCALID: $SLURM_LOCALID"
python check_pytorch.py
