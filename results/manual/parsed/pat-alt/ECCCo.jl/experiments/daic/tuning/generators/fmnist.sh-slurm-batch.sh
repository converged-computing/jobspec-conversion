#!/bin/bash
#SBATCH --job-name=Grid-search Fashion MNIST (ECCCo)
#SBATCH --nodes=1
#SBATCH --ntasks=1000
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=1-08:00:00
#SBATCH --partition=general

module use /opt/insy/modulefiles          # Use DAIC INSY software collection
module load openmpi
srun julia --project=experiments experiments/run_experiments.jl -- data=fmnist output_path=results mpi grid_search > experiments/grid_search_fmnist.log
