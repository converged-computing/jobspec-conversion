#!/bin/bash
#FLUX: --job-name=fuzzy-hope-0766
#FLUX: -N=2
#FLUX: -c=32
#FLUX: -t=7200
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
module purge
module load cesga/system miniconda3/22.11
eval "$(conda shell.bash hook)"
conda deactivate
source $STORE/mytorchdist/bin/activate
srun mnist.sh
