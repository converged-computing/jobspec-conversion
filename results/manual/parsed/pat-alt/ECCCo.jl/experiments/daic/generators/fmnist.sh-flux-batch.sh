#!/bin/bash
#FLUX: --job-name="Fashion MNIST - Grid (ECCCo)"
#FLUX: -n=40
#FLUX: -c=10
#FLUX: --queue=general
#FLUX: -t=7200
#FLUX: --priority=16

module use /opt/insy/modulefiles          # Use DAIC INSY software collection
module load openmpi
source experiments/slurm_header.sh
srun julia --project=experiments --threads $SLURM_CPUS_PER_TASK experiments/run_experiments.jl -- data=fmnist output_path=results mpi grid_search threaded n_individuals=25 n_each=32 > experiments/logs/grid_search_fmnist.log
