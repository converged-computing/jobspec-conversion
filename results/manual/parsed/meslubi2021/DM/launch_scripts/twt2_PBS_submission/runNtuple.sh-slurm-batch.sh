#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/meslubi2021/DM/launch_scripts/twt2_PBS_submission/runNtuple.sh
