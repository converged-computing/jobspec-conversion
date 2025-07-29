#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/r-caplier/CGvsNI-SSL/scripts/CGvsNI/CGvsNI-testAutodesk-meanteach.sh
