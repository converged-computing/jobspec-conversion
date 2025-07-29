#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/global-hydrodynamics/CaMa-Flood_v4/gosh/options_full.sh
