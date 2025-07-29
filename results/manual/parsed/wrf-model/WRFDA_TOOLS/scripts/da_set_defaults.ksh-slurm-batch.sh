#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/wrf-model/WRFDA_TOOLS/scripts/da_set_defaults.ksh
