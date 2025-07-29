#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NOAA-EMC/fv3gfs/driver/gfs/run_simply_JGLOBAL_NCEPPOST-GFS
