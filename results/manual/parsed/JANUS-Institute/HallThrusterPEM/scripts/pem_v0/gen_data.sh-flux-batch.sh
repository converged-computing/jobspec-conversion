#!/bin/bash
#FLUX: --job-name=gen_data_v0
#FLUX: -c=36
#FLUX: --queue=standard
#FLUX: -t=14400
#FLUX: --urgency=16

export PYTHON_JULIAPKG_OFFLINE='yes'

set -e
echo "Starting job script..."
module load python/3.11.5
export PYTHON_JULIAPKG_OFFLINE=yes
pdm run python scripts/pem_v0/gen_data.py
echo "Finishing job script..."
