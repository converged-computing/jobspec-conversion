#!/bin/bash
#FLUX: --job-name=expensive-cinnamonbun-2469
#FLUX: -n=21
#FLUX: --queue=serc
#FLUX: -t=604800
#FLUX: --urgency=16

export MPI_C_LIBRARIES='/share/software/user/open/openmpi/4.0.3/lib/libmpi.so'
export MPI_INCLUDE_PATH='/share/software/user/open/openmpi/4.0.3/include'

module -q purge
module load openmpi/4.0.3
export MPI_C_LIBRARIES=/share/software/user/open/openmpi/4.0.3/lib/libmpi.so
export MPI_INCLUDE_PATH=/share/software/user/open/openmpi/4.0.3/include
mpirun -n 21 julia $SLURM_JOB_NAME
