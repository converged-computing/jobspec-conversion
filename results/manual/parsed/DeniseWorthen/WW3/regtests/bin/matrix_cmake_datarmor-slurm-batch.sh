#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/DeniseWorthen/WW3/regtests/bin/matrix_cmake_datarmor
