#!/bin/bash
#FLUX: --job-name=reclusive-toaster-1064
#FLUX: -n=16
#FLUX: --queue=parallel
#FLUX: -t=86400
#FLUX: --urgency=16

module purge
module load anaconda3/5.2.0
source ../../../Scripts/venv-urban/bin/activate
python3 tokenizing_dask.py
