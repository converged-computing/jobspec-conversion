#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/KULL-Centre/_2023_Thomasen_Martini/2x_proteins/Run_simulations/ubq/prodrun_mdrun.sh
