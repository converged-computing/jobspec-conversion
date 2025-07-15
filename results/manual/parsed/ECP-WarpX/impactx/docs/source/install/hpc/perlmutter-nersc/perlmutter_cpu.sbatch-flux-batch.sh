#!/bin/bash
#FLUX: --job-name=scruptious-cat-2180
#FLUX: --exclusive
#FLUX: --urgency=16

export SRUN_CPUS_PER_TASK='16  # 8 cores per chiplet, 2x SMP'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'

EXE=./impactx
INPUTS=inputs_small
export SRUN_CPUS_PER_TASK=16  # 8 cores per chiplet, 2x SMP
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
srun --cpu-bind=cores \
  ${EXE} ${INPUTS} \
  > output.txt
