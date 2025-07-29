#!/bin/bash
#SBATCH --output=Distributed_SimuLin.log-%j
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1

source /etc/profile
module load julia/1.8.5
julia Simulation_distrv1Log.jl
