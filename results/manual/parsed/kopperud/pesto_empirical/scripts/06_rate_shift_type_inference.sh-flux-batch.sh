#!/bin/bash
#FLUX: --job-name=rate_shift_type
#FLUX: -c=100
#FLUX: --queue=krypton
#FLUX: --urgency=16

export R_HOME='/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R'
export LD_LIBRARY_PATH='/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R/lib'

module load R/4.3.2 gnu openblas
export R_HOME="/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R"
export LD_LIBRARY_PATH="/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R/lib"
julia --threads ${SLURM_CPUS_PER_TASK} scripts/06_rate_shift_type_inference.jl > logs/rate_shift_type_inference.txt
