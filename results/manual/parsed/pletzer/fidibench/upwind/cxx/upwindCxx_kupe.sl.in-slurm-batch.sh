#!/bin/bash
#FLUX: --job-name=upwindCxx
#FLUX: --queue=NeSI
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_PROC_BIND='true'
export OMP_PLACES='cores'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_PROC_BIND=true
export OMP_PLACES=cores
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
exe="@CMAKE_BINARY_DIR@/upwind/cxx/upwindCxx"
time srun --hint=nomultithread $exe -numCells 800 -numSteps 10
