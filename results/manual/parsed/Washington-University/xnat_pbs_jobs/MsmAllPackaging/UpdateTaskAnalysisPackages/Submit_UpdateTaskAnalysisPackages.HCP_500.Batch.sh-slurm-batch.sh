#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Washington-University/xnat_pbs_jobs/MsmAllPackaging/UpdateTaskAnalysisPackages/Submit_UpdateTaskAnalysisPackages.HCP_500.Batch.sh
