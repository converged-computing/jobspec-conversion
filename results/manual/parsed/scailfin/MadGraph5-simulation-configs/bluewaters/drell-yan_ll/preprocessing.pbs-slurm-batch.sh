#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/scailfin/MadGraph5-simulation-configs/bluewaters/drell-yan_ll/preprocessing.pbs
