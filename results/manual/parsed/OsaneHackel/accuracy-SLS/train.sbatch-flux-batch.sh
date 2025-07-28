#!/bin/bash
#FLUX: --job-name=fuzzy-caramel-6974
#FLUX: -t=900
#FLUX: --urgency=16

source ~/.bashrc
source $PREAMBLE
conda activate wb
srun --mpi=pmix "$@"
