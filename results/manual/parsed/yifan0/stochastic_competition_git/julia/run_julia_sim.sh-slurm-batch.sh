#!/bin/bash
#SBATCH --job-name=run_sim
#SBATCH --output=sim_%j.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00

module load julia/1.8.5
/usr/bin/time -v julia -t 16 sim.jl
