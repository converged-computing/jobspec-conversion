#!/bin/bash
#FLUX: --job-name=sticky-lemur-1099
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export PMIX_MCA_gds='hash'
export OMPI_MCA_btl_vader_single_copy_mechanism='none'

export OMP_NUM_THREADS=1
export PMIX_MCA_gds=hash
export OMPI_MCA_btl_vader_single_copy_mechanism=none
srun apptainer exec lammps.sif lmp -in in.melt
