#!/bin/bash
#FLUX: --job-name=pump_range_Nmc
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export MKL_NUM_THREADS='${SLURM_CPUS_PER_TASK}'
export HOME='~'

export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export MKL_NUM_THREADS=${SLURM_CPUS_PER_TASK}
export HOME=~
srun julia run/JUSTUS_draft_run/run_parallel_justus_pump.jl ${SLURM_ARRAY_TASK_ID}
