#!/bin/bash
#FLUX: --job-name=1_64
#FLUX: -c=64
#FLUX: -t=7200
#FLUX: --priority=16

export UCX_TLS='self, tcp'

module load OpenMPI/4.1.5-GCC-12.3.0
MAP_BY=socket
export UCX_TLS=self, tcp
mpirun -np 1 --map-by ${MAP_BY}:PE=$SLURM_CPUS_PER_TASK -x OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK -x OMP_PROC_BIND=spread -x OMP_PLACES=cores ./xhpl -p -s 2480 -f mpi/tasks_1_np_64.dat
