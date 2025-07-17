#!/bin/bash
#FLUX: --job-name=64_2
#FLUX: -n=64
#FLUX: -c=2
#FLUX: -t=7200
#FLUX: --urgency=16

export UCX_TLS='self, tcp'

module load OpenMPI/4.1.5-GCC-12.3.0
MAP_BY=socket
export UCX_TLS=self, tcp
mpirun -np $SLURM_NTASKS --map-by ${MAP_BY}:PE=$SLURM_CPUS_PER_TASK -x OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK -x OMP_PROC_BIND=spread -x OMP_PLACES=cores ./xhpl -p -s 2480 -f mpi_mp/tasks_x_np_y.dat
