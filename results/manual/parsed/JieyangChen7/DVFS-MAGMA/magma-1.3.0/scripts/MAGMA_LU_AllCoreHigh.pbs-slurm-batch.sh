#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/JieyangChen7/DVFS-MAGMA/magma-1.3.0/scripts/MAGMA_LU_AllCoreHigh.pbs
