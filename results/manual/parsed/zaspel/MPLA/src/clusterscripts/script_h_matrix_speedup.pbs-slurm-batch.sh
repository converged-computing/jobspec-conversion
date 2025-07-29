#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/zaspel/MPLA/src/clusterscripts/script_h_matrix_speedup.pbs
