#!/bin/bash
#FLUX: --job-name=Grid-search Linearly Separable (ECCCo)
#FLUX: -n=10
#FLUX: -c=5
#FLUX: --queue=general
#FLUX: -t=1800
#FLUX: --urgency=16

module use /opt/insy/modulefiles          # Use DAIC INSY software collection
module load openmpi
source experiments/slurm_header.sh
srun julia --project=experiments --threads $SLURM_CPUS_PER_TASK experiments/run_experiments.jl -- data=linearly_separable output_path=results mpi grid_search n_individuals=10 threaded > experiments/grid_search_linearly_separable.log
