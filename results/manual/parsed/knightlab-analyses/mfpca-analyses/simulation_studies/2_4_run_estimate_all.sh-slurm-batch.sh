#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/knightlab-analyses/mfpca-analyses/simulation_studies/2_4_run_estimate_all.sh
