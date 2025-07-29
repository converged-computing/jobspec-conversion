#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/exascale-genomics/SAIGE-GPU/mvp_gwphewas_study/data_analysis/01_gwas_gpu/scripts_for_run_GIA/create_downsampled_step1_submit_parallel.sh
