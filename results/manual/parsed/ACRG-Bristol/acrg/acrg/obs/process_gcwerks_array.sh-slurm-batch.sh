#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ACRG-Bristol/acrg/acrg/obs/process_gcwerks_array.sh
