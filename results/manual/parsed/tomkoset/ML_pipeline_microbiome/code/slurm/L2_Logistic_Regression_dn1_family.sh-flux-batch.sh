#!/bin/bash
#FLUX: --job-name=L2_logit-dn1_family
#FLUX: --queue=standard
#FLUX: -t=18000
#FLUX: --priority=16

seed=$(($SLURM_ARRAY_TASK_ID - 1))
mkdir -p logs/slurm/
Rscript code/R/main.R --seed $seed --model L2_Logistic_Regression --data  test/data/classification_input_day-1_data_family.csv --hyperparams test/data/hyperparams.csv --outcome dx
