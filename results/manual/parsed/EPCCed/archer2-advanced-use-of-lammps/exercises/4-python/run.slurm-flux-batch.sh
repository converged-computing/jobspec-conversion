#!/bin/bash
#FLUX: --job-name=lmp_py
#FLUX: --queue=standard
#FLUX: -t=300
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export SRUN_CPUS_PER_TASK='$SLURM_CPUS_PER_TASK'

module load lammps-python/15Dec2023
export OMP_NUM_THREADS=1
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK
srun --distribution=block:block --hint=nomultithread python lammps_lj.py
