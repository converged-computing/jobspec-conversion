#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/vaidyanathanms/Lignin_Melt_Solvent/myruns/src_gmx/sh_files/run_preprocess.sh
