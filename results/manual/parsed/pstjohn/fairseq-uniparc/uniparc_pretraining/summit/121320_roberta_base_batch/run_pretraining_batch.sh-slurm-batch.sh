#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pstjohn/fairseq-uniparc/uniparc_pretraining/summit/121320_roberta_base_batch/run_pretraining_batch.sh
