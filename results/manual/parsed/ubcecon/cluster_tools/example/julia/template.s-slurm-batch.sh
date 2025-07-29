#!/bin/bash
#FLUX: --job-name=Julia
#FLUX: -c=16
#FLUX: -t=3600
#FLUX: --urgency=16

module purge
module load gcc/7.3.0 julia/1.2.0
echo
echo "Hostname: $(hostname)"
echo
cat<<EOF | srun julia
using Distributed
num_cores = parse(Int, ENV["SLURM_CPUS_PER_TASK"])
addprocs(num_cores)
include("user_defined_function.jl")
EOF
