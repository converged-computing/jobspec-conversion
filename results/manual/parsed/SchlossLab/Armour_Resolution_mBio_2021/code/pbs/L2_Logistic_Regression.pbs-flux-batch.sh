#!/bin/bash
#FLUX: --job-name=snakemake
#FLUX: --queue=standard
#FLUX: -t=3600
#FLUX: --priority=16

seed=$(($SLURM_ARRAY_TASK_ID - 1))
mkdir -p logs/slurm/
Rscript code/learning/main.R $seed "L2_Logistic_Regression"
