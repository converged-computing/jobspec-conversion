#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/selvaje/YaleRep/LST/preprocess/old/sc1_local_MYD11A2_miss.sh
