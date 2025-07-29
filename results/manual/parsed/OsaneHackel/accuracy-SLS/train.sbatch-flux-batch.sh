#!/bin/bash
#FLUX --job-name=buttery-caramel-7668
#FLUX -t=900
#FLUX --urgency=16

source ~/.bashrc
source $PREAMBLE
conda activate wb
srun --mpi=pmix "$@"
