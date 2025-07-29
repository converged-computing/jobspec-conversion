#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/a-lud/sea-snake-selection/annotation/hydrophis_major/scripts/01-train.sh
