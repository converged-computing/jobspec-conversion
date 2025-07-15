#!/bin/bash
#FLUX: --job-name=hybrid
#FLUX: -n=2
#FLUX: -c=64
#FLUX: -t=36000
#FLUX: --priority=16

export UCX_TLS='self, tcp, HPL_RAM_CAP=1.0'

module load OpenMPI/4.1.5-GCC-12.3.0
export UCX_TLS=self, tcp, HPL_RAM_CAP=1.0
unset OMPI_MCA_osc
NT=32
NR=2
MAP_BY=socket
mpirun --map-by ${MAP_BY}:PE=$NT -np $NR -x OMP_NUM_THREADS=$NT -x OMP_PROC_BIND=spread -x OMP_PLACES=cores ./xhpl -p -t -f mpi_hybrid_openmp_2/hybrid.dat
