#!/bin/bash
#FLUX: --job-name=fuzzy-blackbean-9395
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module unload intel
module unload impi
module unload mvapich2-x
module load intel/19.0.5
module load impi
module load fftw3
module load gsl
LAMMPS=/work2/07732/tg870312/frontera/lammps-21Jul20/src/lmp_intel_cpu_intelmpi
ibrun -n 112 $LAMMPS -in input -var SEED $RANDOM
