#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Sydney-Informatics-Hub/GermlineShortV_biovalidation/Scripts/run_happy_NCIGadi.sh
