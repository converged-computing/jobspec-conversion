#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Coolgenome/TCM/data_preprocess/Treg/p1_sub_Treg_CD4_V5.sh
