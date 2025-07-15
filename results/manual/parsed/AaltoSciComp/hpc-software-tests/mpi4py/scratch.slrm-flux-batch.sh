#!/bin/bash
#FLUX: --job-name=placid-train-5845
#FLUX: -N=16
#FLUX: -t=300
#FLUX: --priority=16

echo Using nodes: $SLURM_NODELIST
source $WRKDIR/miniconda3/etc/profile.d/conda.sh
conda activate tf2
mpirun python barrier.py
