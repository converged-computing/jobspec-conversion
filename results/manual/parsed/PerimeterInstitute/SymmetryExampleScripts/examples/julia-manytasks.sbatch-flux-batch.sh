#!/bin/bash
#FLUX: --job-name=julia-manytasks
#FLUX: -N=4
#FLUX: --queue=debugq
#FLUX: -t=600
#FLUX: --urgency=16

set -euxo pipefail
module load slurm
module load julia
pwd
echo "SLURM_JOB_ID=$SLURM_JOB_ID"
date
machinefile=$(mktemp)
seq $SLURM_CPUS_ON_NODE |
    xargs -n 1 -I '{}' scontrol show hostnames |
    sort >$machinefile
julia --machine-file $machinefile julia-manytasks.jl
date
