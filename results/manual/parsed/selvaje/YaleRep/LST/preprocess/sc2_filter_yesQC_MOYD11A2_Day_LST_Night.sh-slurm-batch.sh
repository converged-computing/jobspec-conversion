#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/selvaje/YaleRep/LST/preprocess/sc2_filter_yesQC_MOYD11A2_Day_LST_Night.sh
