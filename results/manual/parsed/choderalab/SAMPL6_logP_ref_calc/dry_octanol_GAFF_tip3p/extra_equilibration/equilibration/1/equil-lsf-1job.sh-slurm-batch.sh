#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/SAMPL6_logP_ref_calc/dry_octanol_GAFF_tip3p/extra_equilibration/equilibration/1/equil-lsf-1job.sh
