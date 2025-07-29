#!/bin/bash
#FLUX --job-name=bloated-parrot-8137
#FLUX -N=16
#FLUX -t=300
#FLUX --urgency=16

echo Using nodes: $SLURM_NODELIST
source $WRKDIR/miniconda3/etc/profile.d/conda.sh
conda activate tf2
mpirun python barrier.py
