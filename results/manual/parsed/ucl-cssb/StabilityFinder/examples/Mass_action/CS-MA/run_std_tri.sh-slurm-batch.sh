#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ucl-cssb/StabilityFinder/examples/Mass_action/CS-MA/run_std_tri.sh
