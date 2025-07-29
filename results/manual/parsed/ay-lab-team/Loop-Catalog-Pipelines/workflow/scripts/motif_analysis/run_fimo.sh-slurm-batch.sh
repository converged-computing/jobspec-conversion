#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ay-lab-team/Loop-Catalog-Pipelines/workflow/scripts/motif_analysis/run_fimo.sh
