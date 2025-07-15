#!/bin/bash
#FLUX: --job-name=swimming-data
#FLUX: -n=64
#FLUX: --queue=highmem
#FLUX: -t=72000
#FLUX: --priority=16

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module purge
module load openmpi/4.0.5/amd
module load conda
source activate an
python collect_save.py
