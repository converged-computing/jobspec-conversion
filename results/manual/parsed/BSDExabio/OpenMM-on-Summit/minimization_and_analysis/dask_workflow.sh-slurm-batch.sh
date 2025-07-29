#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/BSDExabio/OpenMM-on-Summit/minimization_and_analysis/dask_workflow.sh
