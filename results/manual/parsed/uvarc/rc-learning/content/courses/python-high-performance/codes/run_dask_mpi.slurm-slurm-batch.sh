#!/bin/bash
#SBATCH --account=hpc_build
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00

export OMPI_MCA_mpi_warn_on_fork='0'

module load gcc/11.4.0
module load openmpi
module load anaconda
export OMPI_MCA_mpi_warn_on_fork=0
srun python dask_df_mpi.py
