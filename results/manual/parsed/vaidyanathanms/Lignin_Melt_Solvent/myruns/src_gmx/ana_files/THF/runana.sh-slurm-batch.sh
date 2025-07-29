#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/vaidyanathanms/Lignin_Melt_Solvent/myruns/src_gmx/ana_files/THF/runana.sh
