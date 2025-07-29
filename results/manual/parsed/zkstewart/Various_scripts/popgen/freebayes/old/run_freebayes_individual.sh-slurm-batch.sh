#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/zkstewart/Various_scripts/popgen/freebayes/old/run_freebayes_individual.sh
