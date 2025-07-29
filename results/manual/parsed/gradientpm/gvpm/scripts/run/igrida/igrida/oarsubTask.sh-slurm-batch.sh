#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/gradientpm/gvpm/scripts/run/igrida/igrida/oarsubTask.sh
