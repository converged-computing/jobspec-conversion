#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/guillaumeeb/big-data-frameworks-on-pbs/dask/launch-dask-cluster-with-module.pbs
