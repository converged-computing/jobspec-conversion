#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pstjohn/fairseq-uniparc/go_annotation/summit/submission_scripts/submit_cafa3_preinit.sh
