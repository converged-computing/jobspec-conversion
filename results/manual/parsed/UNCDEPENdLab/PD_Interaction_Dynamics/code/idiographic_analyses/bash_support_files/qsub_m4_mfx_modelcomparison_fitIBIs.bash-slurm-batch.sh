#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UNCDEPENdLab/PD_Interaction_Dynamics/code/idiographic_analyses/bash_support_files/qsub_m4_mfx_modelcomparison_fitIBIs.bash
