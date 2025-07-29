#!/bin/bash
#SBATCH --job-name=julia-manytasks
#SBATCH --output=julia-manytasks.out
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=debugq

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
