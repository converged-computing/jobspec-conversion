#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ML4HPC/4D_fMRI_Transformer/scripts/polaris/prod_ABCD_main_step3_age_cleaned_split1.pbs
