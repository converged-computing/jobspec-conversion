#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/SAMPL6_logP_ref_calc/dry_octanol_GAFF_tip3p/dry_runs/t3/dry_yank_run-lsf.sh
