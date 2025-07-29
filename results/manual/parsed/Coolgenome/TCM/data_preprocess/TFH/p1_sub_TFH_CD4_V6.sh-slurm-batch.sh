#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Coolgenome/TCM/data_preprocess/TFH/p1_sub_TFH_CD4_V6.sh
