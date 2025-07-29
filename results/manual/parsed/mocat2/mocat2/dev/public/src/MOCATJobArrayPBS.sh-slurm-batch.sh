#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mocat2/mocat2/dev/public/src/MOCATJobArrayPBS.sh
