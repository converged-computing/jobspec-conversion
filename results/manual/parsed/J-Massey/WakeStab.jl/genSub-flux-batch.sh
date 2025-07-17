#!/bin/bash
#FLUX: --job-name=wake-RA
#FLUX: -N=2
#FLUX: -n=128
#FLUX: --queue=highmem
#FLUX: -t=72000
#FLUX: --urgency=16

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module purge
module load conda
source activate an
module load texlive
python src/DMD-RA-working.py
