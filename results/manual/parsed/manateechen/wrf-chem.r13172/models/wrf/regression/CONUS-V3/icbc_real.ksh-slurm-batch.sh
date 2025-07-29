#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/manateechen/wrf-chem.r13172/models/wrf/regression/CONUS-V3/icbc_real.ksh
