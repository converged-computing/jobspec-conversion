#!/bin/bash
#SBATCH --output=simulation_threads.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=48

source /etc/profile
module load julia/1.8.5
julia --threads 48 SimulationThread.jl
