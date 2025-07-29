#!/bin/bash
#FLUX: --job-name=Grid-search Fashion MNIST (ECCCo)
#FLUX: -n=1000
#FLUX: --queue=general
#FLUX: -t=115200
#FLUX: --urgency=16

module use /opt/insy/modulefiles          # Use DAIC INSY software collection
module load openmpi
srun julia --project=experiments experiments/run_experiments.jl -- data=fmnist output_path=results mpi grid_search > experiments/grid_search_fmnist.log
