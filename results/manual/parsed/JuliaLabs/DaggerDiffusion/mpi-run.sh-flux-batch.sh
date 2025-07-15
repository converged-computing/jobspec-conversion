#!/bin/bash
#FLUX: --job-name=dirty-lamp-9453
#FLUX: --priority=16

export UCX_ERROR_SIGNALS='SIGILL,SIGBUS,SIGFPE'

export UCX_ERROR_SIGNALS="SIGILL,SIGBUS,SIGFPE"
module list
srun --mpi=pmi2 julia --project main.jl
