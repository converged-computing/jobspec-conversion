#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CasperAntonPoulsen/Thesis-Synthex/jobs/lsf10/classification/train_enriched_2_synthex.job
