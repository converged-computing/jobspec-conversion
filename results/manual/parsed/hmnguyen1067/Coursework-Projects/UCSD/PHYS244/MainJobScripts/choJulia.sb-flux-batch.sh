#!/bin/bash
#FLUX: --job-name="choJL"
#FLUX: -c=16
#FLUX: --queue=shared
#FLUX: --priority=16

export JULIA_NUM_THREADS='16'

module purge
module load slurm
module load cpu
module load gcc
module load julia
module load intel-mkl
export JULIA_NUM_THREADS=16
srun hostname -s > hostfile
sleep 5
julia --machine-file ./hostfile ./choFinalJL.jl
