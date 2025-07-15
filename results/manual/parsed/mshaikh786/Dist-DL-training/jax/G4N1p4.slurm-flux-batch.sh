#!/bin/bash
#FLUX: --job-name=reclusive-noodle-0894
#FLUX: -n=4
#FLUX: -c=4
#FLUX: -t=300
#FLUX: --priority=16

export IMAGE='$JAX_IMAGE'

scontrol show job ${SLURM_JOBID} 
module load dl
module load jax/23.10-sif
export IMAGE=$JAX_IMAGE
srun -u -n ${SLURM_NTASKS} -N ${SLURM_NNODES} singularity run --nv $IMAGE python query_v1.py
