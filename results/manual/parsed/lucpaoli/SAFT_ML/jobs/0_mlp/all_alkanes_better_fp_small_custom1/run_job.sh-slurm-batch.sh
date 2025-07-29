#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/lucpaoli/SAFT_ML/jobs/0_mlp/all_alkanes_better_fp_small_custom1/run_job.sh
