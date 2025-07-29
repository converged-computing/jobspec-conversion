#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/MorrellLAB/Deleterious_GP/Analysis_Scripts/Data_Handling/Alchemy_Calls.sh
