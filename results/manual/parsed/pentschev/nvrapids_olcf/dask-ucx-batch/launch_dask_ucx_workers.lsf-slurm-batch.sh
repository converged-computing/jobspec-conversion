#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pentschev/nvrapids_olcf/dask-ucx-batch/launch_dask_ucx_workers.lsf
