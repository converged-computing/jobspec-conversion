#!/bin/bash
#FLUX: --job-name=butterscotch-parsnip-5534
#FLUX: -n=24
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
