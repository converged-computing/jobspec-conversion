#!/bin/bash
#FLUX: --job-name=DMD
#FLUX: -n=64
#FLUX: --queue=highmem
#FLUX: -t=72000
#FLUX: --urgency=16

echo "Starting calculation at $(date)"
echo "---------------------------------------------------------------"
module purge
module load texlive
module load conda
source activate an
sleep 720000
