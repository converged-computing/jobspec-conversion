#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/hongli-wang/global-workflow-gsl-w/driver/product/run_JGFS_WAFS.cray
