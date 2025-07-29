#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/johnpzh/parallel_ANNS/scripts/sciclone/load.PSS_DEEP100M_T4.sh
