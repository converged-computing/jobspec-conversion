#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/zaspel/MPLA/src/clusterscripts/amg_poisson_3d_amg2013.pbs
