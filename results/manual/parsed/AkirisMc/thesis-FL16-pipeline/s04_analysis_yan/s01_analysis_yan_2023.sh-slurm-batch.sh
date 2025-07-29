#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/AkirisMc/thesis-FL16-pipeline/s04_analysis_yan/s01_analysis_yan_2023.sh
