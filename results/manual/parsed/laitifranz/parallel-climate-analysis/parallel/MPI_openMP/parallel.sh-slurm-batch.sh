#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/laitifranz/parallel-climate-analysis/parallel/MPI_openMP/parallel.sh
