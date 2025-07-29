#!/bin/bash
#FLUX --job-name=reclusive-lettuce-0035
#FLUX --queue=gpu
#FLUX --urgency=16

export ALPHAFOLD_WORK='/gs/gsfs0/users/gstefan/work/alphafold'

export ALPHAFOLD_WORK="/gs/gsfs0/users/gstefan/work/alphafold"
cd $ALPHAFOLD_WORK
singularity pull ubuntu.sif docker://library/ubuntu:latest
singularity pull alphafold.sif docker://catgumag/alphafold
singularity shell --nv alphafold.sif nvidia-smi
