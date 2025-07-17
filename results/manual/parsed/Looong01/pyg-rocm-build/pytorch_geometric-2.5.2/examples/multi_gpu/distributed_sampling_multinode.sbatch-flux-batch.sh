#!/bin/bash
#FLUX: --job-name=pyg-multinode-tutorial
#FLUX: -N=2
#FLUX: -n=4
#FLUX: -c=8
#FLUX: --gpus-per-task=1
#FLUX: --queue=gpucloud
#FLUX: --urgency=16

export MASTER_PORT='$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'

export MASTER_PORT=$(expr 10000 + $(echo -n $SLURM_JOBID | tail -c 4))
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
echo "MASTER_ADDR:MASTER_PORT="${MASTER_ADDR}:${MASTER_PORT}
echo "###########################################################################"
echo "We recommend you set up your environment here (conda/spack/pip/modulefiles)"
echo "then remove --export=ALL (allows running the sbatch from any shell"
echo "###########################################################################"
srun --output=0 python distributed_sampling_multinode.py
