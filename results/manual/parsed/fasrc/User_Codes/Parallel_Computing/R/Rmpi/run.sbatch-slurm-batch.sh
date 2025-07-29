#!/bin/bash
#SBATCH --job-name=mpi_test
#SBATCH --output=mpi_test.out
#SBATCH --error=mpi_test.err
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=00:30:00

export R_LIBS_USER='$HOME/apps/R/3.5.1:$R_LIBS_USER'
export R_PROFILE='$HOME/apps/R/3.5.1/Rmpi/Rprofile'
export OMPI_MCA_mpi_warn_on_fork='0'

module load R/3.5.1-fasrc01
module load gcc/10.2.0-fasrc01 openmpi/4.1.1-fasrc01
export R_LIBS_USER=$HOME/apps/R/3.5.1:$R_LIBS_USER
export R_PROFILE=$HOME/apps/R/3.5.1/Rmpi/Rprofile
export OMPI_MCA_mpi_warn_on_fork=0
srun -n 8 --mpi=pmix R CMD BATCH --no-save --no-restore mpi_test.R
