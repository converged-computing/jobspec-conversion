#!/bin/bash
#FLUX: --job-name=mpi-diffusion
#FLUX: -t=3600
#FLUX: --urgency=16

export UCX_ERROR_SIGNALS='SIGILL,SIGBUS,SIGFPE'

export UCX_ERROR_SIGNALS="SIGILL,SIGBUS,SIGFPE"
module list
srun --mpi=pmi2 julia --project main.jl
