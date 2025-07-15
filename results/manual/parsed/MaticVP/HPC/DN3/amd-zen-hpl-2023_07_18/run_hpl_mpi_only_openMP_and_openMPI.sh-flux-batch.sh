#!/bin/bash
#FLUX: --job-name=hpl-benchmark
#FLUX: -c=128
#FLUX: -t=36000
#FLUX: --priority=16

export UCX_TLS='self, tcp'

module load OpenMPI/4.1.5-GCC-12.3.0
unset OMPI_MCA_osc
NT=$(lscpu | awk '/per socket:/{print $4}')
NR=2
MAP_BY=socket
MAP_BY=socket
NUM_CORES_PER_SOCKET=64
export UCX_TLS=self, tcp
mpirun --map-by socket:PE=$NUM_CORES_PER_SOCKET  -x OMP_NUM_THREADS=128 -x OMP_PROC_BIND=spread -x OMP_PLACES=cores -np $SLURM_NTASKS ./xhpl -p
