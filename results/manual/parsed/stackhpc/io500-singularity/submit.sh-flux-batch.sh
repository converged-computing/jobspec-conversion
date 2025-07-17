#!/bin/bash
#FLUX: --job-name=muffled-malarkey-5973
#FLUX: -n=2
#FLUX: --exclusive
#FLUX: --urgency=16

export UCX_NET_DEVICES='all'
export IO500_CONTAINER_TAG='9d75358'

export UCX_NET_DEVICES=all
export IO500_CONTAINER_TAG="9d75358"
echo SLURM_JOB_NODELIST: $SLURM_JOB_NODELIST
echo SLURM_JOB_ID: $SLURM_JOB_ID
echo UCX_NET_DEVICES: $UCX_NET_DEVICES
module load gnu12 openmpi4
timestamp=$(date +%Y.%m.%d-%H.%M.%S)
mpirun singularity exec docker://ghcr.io/stackhpc/io500-singularity:${IO500_CONTAINER_TAG} /io500 $1 --timestamp $timestamp
