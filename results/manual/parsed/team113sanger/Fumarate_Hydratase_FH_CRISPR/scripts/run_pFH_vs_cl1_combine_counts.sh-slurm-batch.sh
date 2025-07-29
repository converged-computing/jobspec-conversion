#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/team113sanger/Fumarate_Hydratase_FH_CRISPR/scripts/run_pFH_vs_cl1_combine_counts.sh
