#!/bin/bash
#FLUX: --job-name=BULKBOX
#FLUX: -n=128
#FLUX: --queue=compute
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export PLUMED_NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export PLUMED_NUM_THREADS=$SLURM_CPUS_PER_TASK
source ~/env/lammps.sh
cycles=2
threads_per_partition=1
module load fftw openmpi
srun $LAMMPS_EXE -in start.lmp
