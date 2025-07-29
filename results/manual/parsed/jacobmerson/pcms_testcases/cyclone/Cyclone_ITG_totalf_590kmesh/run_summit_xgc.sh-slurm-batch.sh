#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jacobmerson/pcms_testcases/cyclone/Cyclone_ITG_totalf_590kmesh/run_summit_xgc.sh
