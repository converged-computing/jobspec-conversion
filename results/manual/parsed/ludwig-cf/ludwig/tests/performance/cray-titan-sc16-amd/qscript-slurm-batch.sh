#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ludwig-cf/ludwig/tests/performance/cray-titan-sc16-amd/qscript
