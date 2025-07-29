#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pstjohn/uniparc_modeling/subcellular_localization/submit_localization_model.lsf
