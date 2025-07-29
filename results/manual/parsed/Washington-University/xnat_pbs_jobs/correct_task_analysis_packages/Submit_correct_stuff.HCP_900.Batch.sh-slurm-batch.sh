#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Washington-University/xnat_pbs_jobs/correct_task_analysis_packages/Submit_correct_stuff.HCP_900.Batch.sh
