#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/noaa-oar-arl/NACC/parallel/scripts/run-nacc-fv3.ksh
