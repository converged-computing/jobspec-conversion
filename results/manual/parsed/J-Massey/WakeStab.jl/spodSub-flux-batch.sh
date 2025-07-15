#!/bin/bash
#FLUX: --job-name=SPOD
#FLUX: -N=2
#FLUX: -n=128
#FLUX: --exclusive
#FLUX: --queue=highmem
#FLUX: -t=36000
#FLUX: --priority=16

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module purge
module load conda
source activate an
module load texlive
python src/SPOD.py
