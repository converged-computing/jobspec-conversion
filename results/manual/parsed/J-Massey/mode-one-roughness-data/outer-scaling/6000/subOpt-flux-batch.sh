#!/bin/bash
#FLUX: --job-name=6k_n4
#FLUX: -N=4
#FLUX: -n=256
#FLUX: --queue=amd
#FLUX: -t=216000
#FLUX: --urgency=16

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module purge
module load conda
source activate an
module load openmpi/4.0.5/amd
python run-val.py
