#!/bin/bash
#FLUX: --job-name=eccentric-gato-5394
#FLUX: --exclusive
#FLUX: --priority=16

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
