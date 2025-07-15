#!/bin/bash
#FLUX: --job-name=fugly-underoos-0013
#FLUX: --exclusive
#FLUX: --priority=16

export PATH='/users/PZS0530/skhuvis/opt/mambaforge/22.9.0-2/bin:$PATH #mamba'
export PYTHONUNBUFFERED='TRUE'

module load python/3.7-2019.10
export PATH=/users/PZS0530/skhuvis/opt/mambaforge/22.9.0-2/bin:$PATH #mamba
source activate s2s2
export PYTHONUNBUFFERED=TRUE
python ./mosaic.py
