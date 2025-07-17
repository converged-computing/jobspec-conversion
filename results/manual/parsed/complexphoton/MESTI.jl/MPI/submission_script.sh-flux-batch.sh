#!/bin/bash
#FLUX: --job-name=hybrid_mpi_job
#FLUX: -N=2
#FLUX: -c=16
#FLUX: --queue=debug
#FLUX: -t=600
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

source /project/cwhsu_38/shared/software/mumps-5.6.2-par/setup.sh # preload BLAS, LAPACK, ScaLAPACK, METIS, and MUMPS libraries
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
date
echo HOSTNAME: $HOSTNAME
echo HOSTTYPE: $HOSTTYPE
lscpu
srun --mpi=pmi2 -n $SLURM_NTASKS julia hybrid_mpi.jl
