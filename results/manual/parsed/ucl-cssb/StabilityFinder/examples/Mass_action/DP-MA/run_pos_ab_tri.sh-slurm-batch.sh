#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ucl-cssb/StabilityFinder/examples/Mass_action/DP-MA/run_pos_ab_tri.sh
