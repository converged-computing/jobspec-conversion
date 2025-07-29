#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/orfeotoolbox/let-it-snow/hpc/run_lis_from_filelist.sh
