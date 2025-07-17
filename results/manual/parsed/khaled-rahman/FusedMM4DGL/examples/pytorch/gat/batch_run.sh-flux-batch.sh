#!/bin/bash
#FLUX: --job-name=FusedMM4DGL
#FLUX: --queue=azad
#FLUX: -t=541800
#FLUX: --urgency=16

module unload gcc
module load gcc
srun -p azad -N 1 -n 1 -c 1 bash run_all.sh
