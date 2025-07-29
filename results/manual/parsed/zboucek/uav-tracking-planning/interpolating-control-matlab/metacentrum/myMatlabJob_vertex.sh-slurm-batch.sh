#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/zboucek/uav-tracking-planning/interpolating-control-matlab/metacentrum/myMatlabJob_vertex.sh
