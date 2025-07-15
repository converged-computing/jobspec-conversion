#!/bin/bash
#FLUX: --job-name=up_vs_down_joint
#FLUX: -c=40
#FLUX: --queue=krypton
#FLUX: --urgency=16

export R_HOME='/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R'
export LD_LIBRARY_PATH='/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R/lib'

module load R/4.3.2 gnu openblas
export R_HOME="/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R"
export LD_LIBRARY_PATH="/opt/cres/lib/hpc/gcc7/R/4.2.3/lib64/R/lib"
julia --threads ${SLURM_CPUS_PER_TASK} scripts/up_vs_down_inference_joint.jl > logs/up_vs_down_joint.txt
