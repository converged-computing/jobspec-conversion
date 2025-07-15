#!/bin/bash
#FLUX: --job-name=arid-arm-2815
#FLUX: --priority=16

module purge
module load anaconda3/5.2.0
source ../../../Scripts/venv-urban/bin/activate
python3 tokenizing_dask.py
