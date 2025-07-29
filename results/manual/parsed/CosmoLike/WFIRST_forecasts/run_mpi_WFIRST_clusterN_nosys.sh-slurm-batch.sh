#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CosmoLike/WFIRST_forecasts/run_mpi_WFIRST_clusterN_nosys.sh
