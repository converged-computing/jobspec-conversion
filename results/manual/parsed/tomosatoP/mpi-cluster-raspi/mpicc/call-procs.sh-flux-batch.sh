#!/bin/bash
#FLUX: --job-name=MPICC
#FLUX: -N=3
#FLUX: -n=9
#FLUX: --queue=debug
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export PMIX_MCA_gds='hash'
export OMPI_MCA_btl_vader_single_copy_mechanism='none'

export OMP_NUM_THREADS=1
export PMIX_MCA_gds=hash
export OMPI_MCA_btl_vader_single_copy_mechanism=none
srun apptainer exec mpicc.sif call-procs
