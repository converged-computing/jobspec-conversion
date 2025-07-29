#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/lucpaoli/SAFT_ML/jobs/0_mlp/linear_alkanes_bounded_output_V2/run_job.sh
