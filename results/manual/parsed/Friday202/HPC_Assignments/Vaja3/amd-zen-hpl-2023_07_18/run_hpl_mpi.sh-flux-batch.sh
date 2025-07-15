#!/bin/bash
#FLUX: --job-name=hpl-benchmark
#FLUX: -n=2
#FLUX: -t=7200
#FLUX: --priority=16

export UCX_TLS='self, tcp'

module load OpenMPI/4.1.5-GCC-12.3.0
export UCX_TLS=self, tcp
mpirun -np $SLURM_NTASKS ./xhpl -p -s 2480 -f HPL.dat
