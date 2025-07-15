#!/bin/bash
#FLUX: --job-name="Grid-search Linearly Separable (ECCCo)"
#FLUX: -n=5
#FLUX: -c=4
#FLUX: --queue=compute
#FLUX: -t=3600
#FLUX: --priority=16

module load 2023r1 openmpi
source experiments/slurm_header.sh
srun julia --project=experiments --threads $SLURM_CPUS_PER_TASK experiments/run_experiments.jl -- data=linearly_separable,moons,circles,gmsc,german_credit,california_housing output_path=results_testing mpi grid_search n_individuals=5 threaded > experiments/logs/all_testing.log
