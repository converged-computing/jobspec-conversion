#!/bin/bash
#SBATCH --job-name=DDCP
#SBATCH --mail-user=yuting.mou@uclouvain.be
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4000
#SBATCH --time=04:30:00

export SLURM_NODEFILE='`generate_pbs_nodefile`'

export SLURM_NODEFILE=`generate_pbs_nodefile`
julia --depwarn=no --machinefile $SLURM_NODEFILE ./source/Main.jl
