#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ocean-transport/pleiades_llc_recipes/dask_mpi_plus_notebook.sh
