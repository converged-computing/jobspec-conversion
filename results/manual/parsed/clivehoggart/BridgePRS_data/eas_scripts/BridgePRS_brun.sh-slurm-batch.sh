#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/clivehoggart/BridgePRS_data/eas_scripts/BridgePRS_brun.sh
