#!/bin/bash
#FLUX: --job-name=rainbow-blackbean-1814
#FLUX: --urgency=16

module purge
module load anaconda3/5.2.0
source ../../../Scripts/venv-urban/bin/activate
python3 tokenizing_dask.py
