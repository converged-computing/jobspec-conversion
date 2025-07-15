#!/bin/bash
#FLUX: --job-name=install_deps
#FLUX: -n=2
#FLUX: --queue=krypton
#FLUX: --priority=16

export R_HOME='/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R'
export LD_LIBRARY_PATH='/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R/lib'

module load R/4.3.2 gnu openblas
export R_HOME="/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R"
export LD_LIBRARY_PATH="/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R/lib"
julia scripts/setup/dependencies.jl > logs/jldep.txt
