#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/benkirk/bugreports/gust/openmpi/cuda_aware/run_casper.sh
