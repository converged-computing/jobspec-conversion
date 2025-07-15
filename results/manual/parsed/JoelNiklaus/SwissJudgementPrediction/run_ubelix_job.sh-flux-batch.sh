#!/bin/bash
#FLUX: --job-name="SJP"
#FLUX: --queue=gpu-invest
#FLUX: -t=1728000
#FLUX: --priority=16

eval "$(conda shell.bash hook)"
conda activate sjp
bash run.sh --train_type=$1 --train_mode=$2 --model_name=$3 --model_type=$4 --train_languages=$5 --test_languages=$6 --jurisdiction=$7 --data_augmentation_type=$8 --train_sub_datasets=$9 --sub_datasets=${10} \
  --seed=${SLURM_ARRAY_TASK_ID} --debug=False >current-run.out
