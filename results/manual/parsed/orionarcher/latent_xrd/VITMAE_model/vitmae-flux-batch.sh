#!/bin/bash
#FLUX: --job-name=phat-taco-0410
#FLUX: -c=32
#FLUX: --priority=16

export SLURM_CPU_BIND='cores'
export HDF5_USE_FILE_LOCKING='FALSE'
export MASTER_ADDR='$(hostname)'
export MASTER_PORT='29500'

module load python
conda activate dev
export SLURM_CPU_BIND="cores"
export HDF5_USE_FILE_LOCKING=FALSE
export MASTER_ADDR=$(hostname)
export MASTER_PORT=29500
srun -l -u python /global/homes/h/hasitha/latent_xrd/vitmae.py -d nccl --rank-gpu --ranks-per-node=${SLURM_NTASKS_PER_NODE} $@
