#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MobleyLab/SMIRNOFF_paper_code/FreeSolv_repeat_subset/scripts/run-torque.sh
