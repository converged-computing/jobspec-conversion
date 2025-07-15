#!/bin/bash
#FLUX: --job-name=salted-punk-0668
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export PMIX_MCA_gds='hash'
export OMPI_MCA_btl_vader_single_copy_mechanism='none'

export OMP_NUM_THREADS=1
export PMIX_MCA_gds=hash
export OMPI_MCA_btl_vader_single_copy_mechanism=none
srun apptainer exec mpicc.sif mpi-pi
