#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/wilcas/sex_specific_mQTL/mQTL_analyses/pbs_scripts/run_convert_to_mecs.pbs
