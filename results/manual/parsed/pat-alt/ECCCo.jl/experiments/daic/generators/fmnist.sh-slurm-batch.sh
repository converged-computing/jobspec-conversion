#!/bin/bash
#SBATCH --job-name=Fashion MNIST - Grid (ECCCo)
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=02:00:00
#SBATCH --partition=general

module use /opt/insy/modulefiles          # Use DAIC INSY software collection
module load openmpi
source experiments/slurm_header.sh
srun julia --project=experiments --threads $SLURM_CPUS_PER_TASK experiments/run_experiments.jl -- data=fmnist output_path=results mpi grid_search threaded n_individuals=25 n_each=32 > experiments/logs/grid_search_fmnist.log
