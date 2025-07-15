#!/bin/bash
#FLUX: --job-name=spicy-parsnip-8328
#FLUX: --priority=16

eval $(spack load --sh miniconda3)
source activate active-learning
dirname=ModelFitting/CNN_Reg/"${SLURM_ARRAY_TASK_ID}"
mkdir -p $dirname
python3 src/cnn_regression_random_start.py "${SLURM_ARRAY_TASK_ID}" "${dirname}"
