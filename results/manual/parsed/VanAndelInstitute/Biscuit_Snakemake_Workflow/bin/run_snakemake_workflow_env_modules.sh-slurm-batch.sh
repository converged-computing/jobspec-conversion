#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/VanAndelInstitute/Biscuit_Snakemake_Workflow/bin/run_snakemake_workflow_env_modules.sh
