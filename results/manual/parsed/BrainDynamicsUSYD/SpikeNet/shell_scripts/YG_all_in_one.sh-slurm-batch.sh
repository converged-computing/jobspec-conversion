#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/BrainDynamicsUSYD/SpikeNet/shell_scripts/YG_all_in_one.sh
