#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/PAL-UH/transferAL/code/proposed%20algorithm/bda/CreateTargetPoolDatasets.sh
