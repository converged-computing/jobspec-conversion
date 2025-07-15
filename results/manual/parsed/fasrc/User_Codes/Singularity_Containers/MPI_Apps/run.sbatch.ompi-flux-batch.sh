#!/bin/bash
#FLUX: --job-name=stinky-peas-3206
#FLUX: --urgency=16

export UCX_TLS='ib'
export PMIX_MCA_gds='hash'

export UCX_TLS=ib
export PMIX_MCA_gds=hash
module load gcc/10.2.0-fasrc01 
module load openmpi/4.1.1-fasrc01
srun -n 8 --mpi=pmix singularity exec openmpi_test.simg /home/mpitest.x
