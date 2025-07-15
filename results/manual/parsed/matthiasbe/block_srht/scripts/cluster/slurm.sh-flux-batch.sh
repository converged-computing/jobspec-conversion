#!/bin/bash
#FLUX: --job-name=ornery-fudge-0936
#FLUX: -t=432000
#FLUX: --priority=16

					  # %x is job name, %j jobid 
module purge
module load gnu8/8.3.0
julia_exe=/home/mbeauper/julia-1.7.2/bin/julia
JULIA_NUM_THREADS=1
echo "$SLURM_NTASKS tasks"
echo "$SLURM_CPUS_PER_TASK cpus per tasks"
echo "$SLURM_JOB_NUM_NODES nodes"
echo "$SLURM_NTASKS_PER_CORE tasks per core"
echo "$SLURM_NTASKS_PER_NODE tasks per node"
echo "$SLURM_MEM_PER_NODE MB memory per node"
$julia_exe scripts/nystrom.jl
