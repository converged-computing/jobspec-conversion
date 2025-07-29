#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NOAA-EMC/fv3gfs/ecf/ecfutils/CROW/model/fv3gfs/outofcontrol_scripts/wcoss_c/vrfy/gfs_genesis_para_fv3gfs.sh
