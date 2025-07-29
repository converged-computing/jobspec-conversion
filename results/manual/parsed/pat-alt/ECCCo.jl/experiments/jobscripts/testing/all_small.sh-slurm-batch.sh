#!/bin/bash
#SBATCH --job-name=Grid-search Linearly Separable (ECCCo)
#SBATCH --account=innovation
#SBATCH --nodes=1
#SBATCH --ntasks=5
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2GB
#SBATCH --time=01:00:00

module load 2023r1 openmpi
source experiments/slurm_header.sh
srun julia --project=experiments --threads $SLURM_CPUS_PER_TASK experiments/run_experiments.jl -- data=linearly_separable,moons,circles,gmsc,german_credit,california_housing output_path=results_testing mpi grid_search n_individuals=5 threaded > experiments/logs/all_testing.log
