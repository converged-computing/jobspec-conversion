#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/xunpan/magpie/submission-scripts/script-lsf-mpirun/magpie.lsf-mpirun-storm
