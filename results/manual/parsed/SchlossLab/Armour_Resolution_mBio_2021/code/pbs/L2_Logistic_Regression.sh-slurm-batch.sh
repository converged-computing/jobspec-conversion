#!/bin/bash
#FLUX: --job-name=sensspec
#FLUX: --queue=standard
#FLUX: -t=3600
#FLUX: --urgency=16

seed=$(($SLURM_ARRAY_TASK_ID - 1))
mkdir -p logs/slurm/
Rscript code/R/main.R --seed $seed --model L2_Logistic_Regression --data  test/data/small_input_data.csv --hyperparams test/data/hyperparams.csv --outcome dx
