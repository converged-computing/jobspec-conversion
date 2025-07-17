#!/bin/bash
#FLUX: --job-name=chocolate-animal-5722
#FLUX: -t=900
#FLUX: --urgency=16

source ~/.bashrc
source $PREAMBLE
conda activate wb
srun --mpi=pmix "$@"
