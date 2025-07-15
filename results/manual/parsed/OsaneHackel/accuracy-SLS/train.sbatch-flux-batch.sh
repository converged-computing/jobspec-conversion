#!/bin/bash
#FLUX: --job-name=doopy-eagle-6487
#FLUX: -t=900
#FLUX: --urgency=16

source ~/.bashrc
source $PREAMBLE
conda activate wb
srun --mpi=pmix "$@"
