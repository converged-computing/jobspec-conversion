#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/FoldingAtHome/covid-moonshot/synthetic-enumeration/sprint-5-stereofix/05-prepare-all-transformations-lsf-monomer.sh
