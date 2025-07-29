#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Coolgenome/TCM/data_preprocess/proliferative/p1_Proliferative_V4.sh
