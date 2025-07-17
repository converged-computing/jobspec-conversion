#!/bin/bash
#FLUX: --job-name=AUGUR_TEST
#FLUX: -n=24
#FLUX: -t=3600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_ON_NODE'

export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE
