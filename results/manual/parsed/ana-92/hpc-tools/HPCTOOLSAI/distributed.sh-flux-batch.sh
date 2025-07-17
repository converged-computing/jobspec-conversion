#!/bin/bash
#FLUX: --job-name=arid-puppy-5530
#FLUX: -N=2
#FLUX: -c=32
#FLUX: -t=600
#FLUX: --urgency=16

export WORLD_SIZE='4  # Total number of GPUs across all nodes'
export NODE_RANK='$SLURM_NODEID'
export RANK='$SLURM_PROCID'
export PYTHONFAULTHANDLER='1'

module purge
module load cesga/system miniconda3/22.11
eval "$(conda shell.bash hook)"
conda deactivate
source $STORE/mytorchdist/bin/deactivate
source $STORE/mytorchdist/bin/activate
export WORLD_SIZE=4  # Total number of GPUs across all nodes
export NODE_RANK=$SLURM_NODEID
export RANK=$SLURM_PROCID
export PYTHONFAULTHANDLER=1
pythonint=$(which python)
srun python ddp.py
srun python dp.py
