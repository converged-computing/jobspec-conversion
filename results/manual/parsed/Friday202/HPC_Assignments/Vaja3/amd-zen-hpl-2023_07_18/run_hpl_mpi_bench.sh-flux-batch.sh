#!/bin/bash
#FLUX: --job-name=hpl-parameter-search
#FLUX: -n=4
#FLUX: -t=7200
#FLUX: --urgency=16

export UCX_TLS='self, tcp'

module load OpenMPI/4.1.5-GCC-12.3.0
export UCX_TLS=self, tcp
mpirun -np $SLURM_NTASKS --map-by ${MAP_BY}:PE=$NT -np $NR -x OMP_NUM_THREADS=$NT -x OMP_PROC_BIND=spread -x OMP_PLACES=cores ./xhpl -p -s 2480
