#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ucgmsim/slurm_gm_workflow/workflow/automation/org/kisti/plot_ts.pbs
