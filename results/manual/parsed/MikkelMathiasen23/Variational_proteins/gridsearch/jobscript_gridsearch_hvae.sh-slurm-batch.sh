#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MikkelMathiasen23/Variational_proteins/gridsearch/jobscript_gridsearch_hvae.sh
