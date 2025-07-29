#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/saga-project/saga-cpp-legacy-projects/applications/async-re/centralized/script.sh
