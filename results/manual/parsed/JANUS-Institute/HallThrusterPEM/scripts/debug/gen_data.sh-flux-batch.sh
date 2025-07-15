#!/bin/bash
#FLUX: --job-name=gen_data_debug
#FLUX: --queue=standard
#FLUX: -t=180
#FLUX: --priority=16

export PYTHON_JULIAPKG_OFFLINE='yes'

set -e
echo "Starting job script..."
module load python/3.11.5
export PYTHON_JULIAPKG_OFFLINE=yes
pdm run python scripts/debug/gen_data.py
echo "Finishing job script..."
