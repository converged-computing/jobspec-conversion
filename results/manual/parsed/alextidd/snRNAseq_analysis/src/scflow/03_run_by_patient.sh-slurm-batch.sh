#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/alextidd/snRNAseq_analysis/src/scflow/03_run_by_patient.sh
