#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/luisdrita/RoadSafety/pspnet101/run_pspnet_outputs.sh
