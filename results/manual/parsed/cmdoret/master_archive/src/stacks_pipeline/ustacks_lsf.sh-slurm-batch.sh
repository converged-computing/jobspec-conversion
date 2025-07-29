#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/cmdoret/master_archive/src/stacks_pipeline/ustacks_lsf.sh
