#!/bin/bash
#SBATCH --job-name=hybrid_mpi_job
#SBATCH --output=hybrid_mpi.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

source /project/cwhsu_38/shared/software/mumps-5.6.2-par/setup.sh # preload BLAS, LAPACK, ScaLAPACK, METIS, and MUMPS libraries
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
date
echo HOSTNAME: $HOSTNAME
echo HOSTTYPE: $HOSTTYPE
lscpu
srun --mpi=pmi2 -n $SLURM_NTASKS julia hybrid_mpi.jl
