#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/sophiahorigan/PathogenCompetition_ModelFitting/old/old/META_disp_stoch_miser_ls_prior/compiler.sh
