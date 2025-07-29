#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ucl-cssb/StabilityFinder/examples/Lu_switches/LU-CS/run_CS.sh
