#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/FoldingAtHome/covid-moonshot/synthetic-enumeration/sprint-11A/05-prepare-all-transformations-lsf.sh
