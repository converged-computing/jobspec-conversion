#!/bin/bash
#FLUX: --job-name=mpi_job
#FLUX: -n=128
#FLUX: -t=36000
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load mpi/openmpi-4.1.5
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
mpirun $HOME/.juliaup/bin/julia --project=$PWD mpi.jl
