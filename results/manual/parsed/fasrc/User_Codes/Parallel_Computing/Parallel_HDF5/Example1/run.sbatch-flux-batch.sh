#!/bin/bash
#FLUX: --job-name=parallel_hdf5
#FLUX: -N=2
#FLUX: -n=8
#FLUX: --queue=test
#FLUX: -t=600
#FLUX: --urgency=16

module load intel/21.2.0-fasrc01 openmpi/4.1.1-fasrc01 hdf5/1.12.1-fasrc01
srun -n $SLURM_NTASKS -N $SLURM_NNODES --mpi=pmix ./parallel_hdf5.x
