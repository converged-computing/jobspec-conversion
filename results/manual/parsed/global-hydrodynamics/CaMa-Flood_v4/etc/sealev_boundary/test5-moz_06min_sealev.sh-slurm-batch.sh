#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/global-hydrodynamics/CaMa-Flood_v4/etc/sealev_boundary/test5-moz_06min_sealev.sh
