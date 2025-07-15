#!/bin/bash
#FLUX: --job-name=julia_lu
#FLUX: -c=16
#FLUX: --queue=shared
#FLUX: --urgency=16

export JULIA_NUM_THREADS='32'

module purge
module load slurm
module load cpu
module load gcc
module load julia
export JULIA_NUM_THREADS=32
srun hostname -s > hostfile
sleep 5
julia --machine-file ./hostfile ./luDecomJulia.jl
