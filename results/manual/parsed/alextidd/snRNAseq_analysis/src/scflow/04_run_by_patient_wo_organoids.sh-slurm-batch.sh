#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/alextidd/snRNAseq_analysis/src/scflow/04_run_by_patient_wo_organoids.sh
