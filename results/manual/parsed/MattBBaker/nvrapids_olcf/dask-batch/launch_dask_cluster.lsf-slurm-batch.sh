#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MattBBaker/nvrapids_olcf/dask-batch/launch_dask_cluster.lsf
