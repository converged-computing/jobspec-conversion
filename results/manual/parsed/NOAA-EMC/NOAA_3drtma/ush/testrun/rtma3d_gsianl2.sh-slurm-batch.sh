#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NOAA-EMC/NOAA_3drtma/ush/testrun/rtma3d_gsianl2.sh
