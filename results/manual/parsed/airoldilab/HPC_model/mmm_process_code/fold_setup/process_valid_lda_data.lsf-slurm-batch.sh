#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/airoldilab/HPC_model/mmm_process_code/fold_setup/process_valid_lda_data.lsf
