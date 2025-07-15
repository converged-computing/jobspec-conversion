#!/bin/bash
#FLUX: --job-name=lammps_rerun
#FLUX: --queue=standard
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

module load lammps/15Dec2023
export OMP_NUM_THREADS=1
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
srun --distribution=block:block --hint=nomultithread lmp -in rerun.in -partition 10x1
