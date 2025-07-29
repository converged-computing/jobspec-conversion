#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/antoinetran/cnes-globalfit1-container-idasoft/run/run_pbs.sh
