#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/lucpaoli/SAFT_ML/jobs/4_transfer_learning_new_fp/4_attention_noise_1e-4/run_job.sh
