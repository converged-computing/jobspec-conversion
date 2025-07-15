#!/bin/bash
#FLUX: --job-name=purple-nunchucks-1806
#FLUX: -n=4
#FLUX: --priority=16

export OMPI_MCA_mpi_warn_on_fork='0'

module load gcc/11.4.0
module load openmpi
module load anaconda
export OMPI_MCA_mpi_warn_on_fork=0
srun python dask_df_mpi.py
