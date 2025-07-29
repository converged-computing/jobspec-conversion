#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ucd-plse/MPAS-tuning/scripts/build_MPAS_atm_intel.sh
