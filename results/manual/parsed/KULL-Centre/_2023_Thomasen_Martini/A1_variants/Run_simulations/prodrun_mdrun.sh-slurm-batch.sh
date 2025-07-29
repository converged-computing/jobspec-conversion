#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/KULL-Centre/_2023_Thomasen_Martini/A1_variants/Run_simulations/prodrun_mdrun.sh
