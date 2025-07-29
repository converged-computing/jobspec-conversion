#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mark-a-potts/UFS_UTILS/driver_scripts/driver_grid.cray.sh
