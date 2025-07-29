#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Ruchit-rt/fgpa_hardware_accelerateNN/scripts/emulate_build.sh
