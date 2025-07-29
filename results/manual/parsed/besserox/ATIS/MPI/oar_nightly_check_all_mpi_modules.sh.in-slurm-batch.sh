#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/besserox/ATIS/MPI/oar_nightly_check_all_mpi_modules.sh.in
