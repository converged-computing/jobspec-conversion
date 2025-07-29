#!/bin/bash
#SBATCH --job-name=hiv_r15
#SBATCH --account=CHE20010
#SBATCH --output=hiv1_l.out
#SBATCH --error=hiv1_l.err
#SBATCH --nodes=2
#SBATCH --ntasks=112
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --partition=development

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
