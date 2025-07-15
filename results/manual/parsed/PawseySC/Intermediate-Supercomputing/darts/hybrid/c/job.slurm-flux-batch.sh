#!/bin/bash
#FLUX: --job-name=darts-hybrid
#FLUX: -t=300
#FLUX: --priority=16

export OMP_NUM_THREADS='6'
export OMP_PLACES='cores'
export OMP_PROC_BIND='close'

module swap PrgEnv-cray PrgEnv-intel 
export OMP_NUM_THREADS=6
export OMP_PLACES=cores
export OMP_PROC_BIND=close
srun --export=ALL -n 4 -c 6 darts-hybrid
