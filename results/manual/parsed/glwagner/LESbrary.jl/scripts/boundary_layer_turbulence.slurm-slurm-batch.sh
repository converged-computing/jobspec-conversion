#!/bin/bash
#SBATCH --job-name=Oceananigans
#SBATCH --output=slurm.%N.%j_%x.out
#SBATCH --error=slurm.%N.%j_%x.err
#SBATCH --mail-user=alir@mit.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=1-00:00:00

module load openmpi/3.1.4 cuda/10.0
cd $HOME/LESbrary/
julia --project simulation/boundary_layer_turbulence_simple.jl
