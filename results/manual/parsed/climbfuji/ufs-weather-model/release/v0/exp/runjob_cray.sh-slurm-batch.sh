#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/climbfuji/ufs-weather-model/release/v0/exp/runjob_cray.sh
