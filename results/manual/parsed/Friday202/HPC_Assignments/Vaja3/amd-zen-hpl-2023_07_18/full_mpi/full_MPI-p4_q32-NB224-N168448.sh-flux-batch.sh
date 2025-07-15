#!/bin/bash
#FLUX: --job-name=mpi_p4
#FLUX: -n=128
#FLUX: -t=7200
#FLUX: --urgency=16

export UCX_TLS='self, tcp'

module load OpenMPI/4.1.5-GCC-12.3.0
export UCX_TLS=self, tcp
mpirun -np 128 ./xhpl -p -s 24800 -f full_mpi/full_MPI-p4_q32-NB224-N168448.dat
