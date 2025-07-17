#!/bin/bash
#FLUX: --job-name=baseline
#FLUX: -c=32
#FLUX: -t=600
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

module purge
module load cesga/system miniconda3/22.11
eval "$(conda shell.bash hook)"
conda deactivate
source $STORE/mytorchdist/bin/deactivate
source $STORE/mytorchdist/bin/activate
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
which python
srun python baseline.py
