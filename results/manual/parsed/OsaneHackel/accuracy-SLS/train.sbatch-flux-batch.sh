#!/bin/bash
#FLUX: --job-name=anxious-fudge-7366
#FLUX: -t=900
#FLUX: --priority=16

source ~/.bashrc
source $PREAMBLE
conda activate wb
srun --mpi=pmix "$@"
