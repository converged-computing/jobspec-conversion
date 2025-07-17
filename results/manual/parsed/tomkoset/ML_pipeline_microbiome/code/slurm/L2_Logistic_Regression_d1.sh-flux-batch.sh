#!/bin/bash
#FLUX: --job-name=L2_logit-d1
#FLUX: --queue=standard
#FLUX: -t=18000
#FLUX: --urgency=16

seed=$(($SLURM_ARRAY_TASK_ID - 1))
mkdir -p logs/slurm/
Rscript code/R/main.R --seed $seed --model L2_Logistic_Regression --data  test/data/classification_input_day1_data.csv --hyperparams test/data/hyperparams.csv --outcome dx
