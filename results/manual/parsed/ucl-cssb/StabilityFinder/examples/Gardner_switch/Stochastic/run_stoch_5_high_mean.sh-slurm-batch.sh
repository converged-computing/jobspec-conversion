#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ucl-cssb/StabilityFinder/examples/Gardner_switch/Stochastic/run_stoch_5_high_mean.sh
