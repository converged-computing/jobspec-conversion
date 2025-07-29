#!/bin/bash
#FLUX --job-name=hairy-bicycle-6910
#FLUX -t=900
#FLUX --urgency=16

source ~/.bashrc
source $PREAMBLE
conda activate wb
srun --mpi=pmix "$@"
