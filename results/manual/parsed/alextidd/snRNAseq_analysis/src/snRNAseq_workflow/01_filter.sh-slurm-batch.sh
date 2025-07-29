#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/alextidd/snRNAseq_analysis/src/snRNAseq_workflow/01_filter.sh
