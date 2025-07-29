#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UO-OACISS/tau2/tools/src/ToM/scripts/craycnl/jobscript_mpi.sh
