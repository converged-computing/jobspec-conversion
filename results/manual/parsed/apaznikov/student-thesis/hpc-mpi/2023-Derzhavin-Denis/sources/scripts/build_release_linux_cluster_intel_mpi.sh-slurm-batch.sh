#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/apaznikov/student-thesis/hpc-mpi/2023-Derzhavin-Denis/sources/scripts/build_release_linux_cluster_intel_mpi.sh
