#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/pstjohn/fairseq-uniparc/uniparc_pretraining/summit/pretrain_roberta_large/run_pretraining_batch_debug.sh
