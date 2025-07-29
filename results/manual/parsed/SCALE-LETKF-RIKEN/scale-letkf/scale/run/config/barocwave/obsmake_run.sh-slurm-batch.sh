#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/SCALE-LETKF-RIKEN/scale-letkf/scale/run/config/barocwave/obsmake_run.sh
