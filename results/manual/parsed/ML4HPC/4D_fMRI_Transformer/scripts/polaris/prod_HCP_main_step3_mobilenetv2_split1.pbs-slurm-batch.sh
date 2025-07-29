#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ML4HPC/4D_fMRI_Transformer/scripts/polaris/prod_HCP_main_step3_mobilenetv2_split1.pbs
