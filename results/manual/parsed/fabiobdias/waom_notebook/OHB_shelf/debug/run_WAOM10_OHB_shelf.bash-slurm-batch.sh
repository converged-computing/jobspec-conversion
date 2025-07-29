#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/fabiobdias/waom_notebook/OHB_shelf/debug/run_WAOM10_OHB_shelf.bash
