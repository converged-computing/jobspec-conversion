#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pkestene/patc_kokkos/code/exercises/mpi_kokkos/submit_ouessant_gpu.sh
