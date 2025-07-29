#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/munoztd0/OBIWAN/ANALYSIS/T0/dependencies/matlab_oneSubj.sh
