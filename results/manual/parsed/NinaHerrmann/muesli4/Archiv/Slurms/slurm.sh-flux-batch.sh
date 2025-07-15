#!/bin/bash
#FLUX: --job-name=Muesli2
#FLUX: -N=2
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=express
#FLUX: -t=7200
#FLUX: --priority=16

export OMP_NUM_THREADS='4'
export I_MPI_DEBUG='3'
export I_MPI_FABRICS='shm:ofa'

cd /home/k/kuchen/Muesli2
module load intelcuda/2019a
module load CMake/3.15.3
export OMP_NUM_THREADS=4
export I_MPI_DEBUG=3
export I_MPI_FABRICS=shm:ofa
mpirun /home/k/kuchen/Muesli2/build/bin/canny_cpu
