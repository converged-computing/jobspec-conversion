#!/bin/bash
#FLUX: --job-name=heat
#FLUX: -c=32
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='TRUE'
export OMP_NUM_THREADS='32'

export OMP_PLACES=cores
export OMP_PROC_BIND=TRUE
export OMP_NUM_THREADS=32
srun prog 1024 1024 1 1
wait
