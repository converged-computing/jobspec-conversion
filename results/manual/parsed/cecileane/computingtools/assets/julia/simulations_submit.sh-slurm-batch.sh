#!/bin/bash
#SBATCH --job-name=sims
#SBATCH --output=simresults/simulation_%a.log
#SBATCH --mail-user=cecile.ane@wisc.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=1-240

export JULIA_DEPOT_PATH='/workspace/ane/.julia'

export JULIA_DEPOT_PATH="/workspace/ane/.julia"
echo "slurm task ID = $SLURM_ARRAY_TASK_ID"
nreps=20
/workspace/software/julia-1.5.1/bin/julia /workspace/ane/st679simulations/onesimulation.jl $SLURM_ARRAY_TASK_ID $nreps
