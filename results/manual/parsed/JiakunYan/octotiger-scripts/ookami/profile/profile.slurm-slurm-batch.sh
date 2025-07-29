#!/bin/bash
#SBATCH --job-name=profile
#SBATCH --output=slurm_output.%x-o%j
#SBATCH --error=slurm_error.%x-o%j
#SBATCH --nodes=64
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=ntasks-per-node=1

task="rs"
pp="lci"
max_level="6"
mode=${1:-"stat"}
srun --mpi=pmix bash -x ${ROOT_PATH}/profile_wrapper.sh $task $pp $max_level $mode
