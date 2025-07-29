#!/bin/bash
#SBATCH --job-name=mpi4py
#SBATCH --account=GOV109092
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=ntasks-per-node=4

export UCX_LOG_LEVEL='error'

module purge
module load biology/Python/3.9.5
source ~/sandbox/bin/activate
module load compiler/intel/2020u4 OpenMPI/4.1.1
export UCX_LOG_LEVEL=error
mpirun -np ${SLURM_NTASKS} python3 mpi.py
