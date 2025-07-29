#!/bin/bash
#FLUX: --job-name=hpl-benchmark
#FLUX: -t=36000
#FLUX: --urgency=16

export UCX_TLS='self, tcp'

module load OpenMPI/4.1.5-GCC-12.3.0
MAP_BY=socket
NUM_CORES_PER_SOCKET=4 
export UCX_TLS=self, tcp
mpirun --map-by socket:PE=$NUM_CORES_PER_SOCKET  -x OMP_NUM_THREADS=$NUM_CORES_PER_SOCKET -x OMP_PROC_BIND=spread -x OMP_PLACES=cores -np $SLURM_NTASKS ./xhpl -p -s 1000 -c
