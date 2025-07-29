#!/bin/bash
#SBATCH --output=output/%x-%j.out
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00
#SBATCH --qos=medium
#SBATCH --constraint=ntasks-per-node=16
#SBATCH --array=0-1023%32

module load julia
srun julia ./code/StochasticFlexibility/experiments/investment_sensitivity_parallel.jl
