#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/selvaje/YaleRep/LST/preprocess/old/sc1_wget_MOD11A2_wget.sh
