#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/sjfandrews/MitoImputePrep/scripts/BASH/DATA_PROCESSING/SnakeMake_tests/PlatformStrandFiles_Raijin.sh
