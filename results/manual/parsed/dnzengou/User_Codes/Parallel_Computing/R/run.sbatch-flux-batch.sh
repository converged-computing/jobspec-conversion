#!/bin/bash
#FLUX: --job-name=blue-staircase-1795
#FLUX: --priority=16

export R_LIBS_USER='$HOME/software/R/3.6.1:$R_LIBS_USER'
export R_PROFILE='$HOME/software/R/3.6.1/Rmpi/Rprofile'
export OMPI_MCA_mpi_warn_on_fork='0'

module load R/3.6.1-fasrc02
module load gcc/8.2.0-fasrc01 openmpi/4.0.1-fasrc01
export R_LIBS_USER=$HOME/software/R/3.6.1:$R_LIBS_USER
export R_PROFILE=$HOME/software/R/3.6.1/Rmpi/Rprofile
export OMPI_MCA_mpi_warn_on_fork=0
srun -n 8 --mpi=pmix R CMD BATCH --no-save --no-restore mpi_test.R mpi_test.out
