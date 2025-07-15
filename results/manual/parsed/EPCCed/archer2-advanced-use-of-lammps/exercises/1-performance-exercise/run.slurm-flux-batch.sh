#!/bin/bash
#FLUX: --job-name=lmp_bench
#FLUX: --queue=standard
#FLUX: -t=1200
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

module load lammps/15Dec2023
export OMP_NUM_THREADS=1
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
srun lmp -in in.ethanol -l log.out_${SLURM_TASKS_PER_NODE}
