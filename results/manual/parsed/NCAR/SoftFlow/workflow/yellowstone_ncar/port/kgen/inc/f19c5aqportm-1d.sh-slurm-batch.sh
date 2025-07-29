#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/NCAR/SoftFlow/workflow/yellowstone_ncar/port/kgen/inc/f19c5aqportm-1d.sh
