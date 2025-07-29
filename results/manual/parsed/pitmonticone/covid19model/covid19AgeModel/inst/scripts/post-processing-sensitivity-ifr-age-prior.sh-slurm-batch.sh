#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pitmonticone/covid19model/covid19AgeModel/inst/scripts/post-processing-sensitivity-ifr-age-prior.sh
