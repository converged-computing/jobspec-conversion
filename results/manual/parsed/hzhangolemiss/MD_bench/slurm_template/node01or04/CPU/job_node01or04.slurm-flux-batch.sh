#!/bin/bash
#FLUX: --job-name=xxx
#FLUX: -t=2592000
#FLUX: --priority=16

cd $SLURM_SUBMIT_DIR
module load openmpi
module load openblas
module load fftw3
module load lammps/gcc/sfft/openmpi/cuda/2Aug23.3
mpiexec --bind-to core --map-by core -n 40 lmp_mpi -i input.lmps
module purge
