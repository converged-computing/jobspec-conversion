#!/bin/bash
#FLUX: --job-name=Grid-search California Housing (ECCCo)
#FLUX: -n=14
#FLUX: -c=14
#FLUX: --queue=general
#FLUX: -t=2100
#FLUX: --urgency=16

module use /opt/insy/modulefiles          # Use DAIC INSY software collection
module load openmpi
source experiments/slurm_header.sh
srun julia --project=experiments --threads $SLURM_CPUS_PER_TASK experiments/run_experiments.jl -- data=california_housing output_path=results mpi grid_search n_individuals=10 threaded > experiments/grid_search_california_housing.log
