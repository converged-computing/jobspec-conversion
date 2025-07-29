#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/deephyper/scalable-bo/experiments/polaris/dhb/dhb_combo-OPT-TPE-NONE-160-10800.sh
