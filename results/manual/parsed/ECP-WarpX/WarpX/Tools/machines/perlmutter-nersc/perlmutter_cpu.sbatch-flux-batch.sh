#!/bin/bash
#FLUX: --job-name=lovable-arm-3283
#FLUX: --exclusive
#FLUX: --priority=16

export SRUN_CPUS_PER_TASK='16  # 8 cores per chiplet, 2x SMP'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export OMP_NUM_THREADS='${SRUN_CPUS_PER_TASK}'

EXE=./warpx
INPUTS=inputs_small
export SRUN_CPUS_PER_TASK=16  # 8 cores per chiplet, 2x SMP
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
srun --cpu-bind=cores \
  ${EXE} ${INPUTS} \
  > output.txt
