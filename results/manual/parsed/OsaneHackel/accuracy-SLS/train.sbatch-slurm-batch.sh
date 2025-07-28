#!/bin/bash
#FLUX: --job-name=grated-omelette-2813
#FLUX: -t=900
#FLUX: --urgency=16

source ~/.bashrc
source $PREAMBLE
conda activate wb
srun --mpi=pmix "$@"
