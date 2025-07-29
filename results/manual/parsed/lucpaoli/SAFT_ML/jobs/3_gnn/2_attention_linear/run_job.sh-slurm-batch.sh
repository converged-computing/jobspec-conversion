#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/lucpaoli/SAFT_ML/jobs/3_gnn/2_attention_linear/run_job.sh
