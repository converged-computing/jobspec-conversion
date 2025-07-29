#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/a3sha2/CBIG/stable_projects/disorder_subtypes/Sun2019_ADJointFactors/step1_SPM_VBM/code/CBIG_MMLDA_step1b_apply_reorient_matrix.sh
