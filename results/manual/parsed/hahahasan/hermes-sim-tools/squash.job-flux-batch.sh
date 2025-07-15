#!/bin/bash
#FLUX: --job-name=squash
#FLUX: -t=40271
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

echo trying
export OMP_NUM_THREADS=1
python ~/scratch/hermes-sim-tools/x-analysis.py
echo exited
