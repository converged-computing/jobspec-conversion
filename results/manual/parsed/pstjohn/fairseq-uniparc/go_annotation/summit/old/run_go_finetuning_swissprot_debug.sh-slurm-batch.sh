#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pstjohn/fairseq-uniparc/go_annotation/summit/old/run_go_finetuning_swissprot_debug.sh
