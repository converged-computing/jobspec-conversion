#!/bin/bash
#FLUX: --job-name=blank-toaster-7852
#FLUX: -N=16
#FLUX: --queue=cm2_std
#FLUX: -t=1200
#FLUX: --priority=16

module load slurm_setup
module unload intel-mpi/2019-intel
module unload intel-oneapi-compilers/2021.4.0
module unload intel-mkl/2020
module load cmake
module load gcc/11
module load petsc/3.17.2-gcc11-ompi-real
module load openmpi/4.1.2-gcc11
mpirun -n 448 ${HOME}/ns-eof/build/NS-EOF-Runner \
    ${HOME}/runs/Cavity2D-16node.xml
