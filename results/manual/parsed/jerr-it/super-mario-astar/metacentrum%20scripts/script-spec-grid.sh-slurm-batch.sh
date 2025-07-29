#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jerr-it/super-mario-astar/metacentrum%20scripts/script-spec-grid.sh
