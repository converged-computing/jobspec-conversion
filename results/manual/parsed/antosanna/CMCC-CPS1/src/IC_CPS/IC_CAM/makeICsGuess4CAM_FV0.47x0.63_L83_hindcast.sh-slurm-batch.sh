#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/antosanna/CMCC-CPS1/src/IC_CPS/IC_CAM/makeICsGuess4CAM_FV0.47x0.63_L83_hindcast.sh
