#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NOAA-EMC/fv3gfs/sorc/fv3gfs.fd/release/v0/exp/runjob_cray.sh
