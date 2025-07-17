#!/bin/bash
#FLUX: --job-name=vmcts
#FLUX: -c=16
#FLUX: --queue=kempner_requeue
#FLUX: -t=3600
#FLUX: --urgency=16

export PYTHONPATH='.:${PYTHONPATH}'
export model_arg_temps='(0.2 0.4 0.6 0.8 1.0)'
export model_arg_topp='0.95'
export model_arg_topk='0'
export token_limit='5000'
export run_number='$[$SLURM_ARRAY_TASK_ID/5] # 100 runs per hyperparameter'
export hyperparam_number='$[$SLURM_ARRAY_TASK_ID%5]'
export model_arg_temp_idx='$[$hyperparam_number]'
export model_arg_temp='${model_arg_temps[$model_arg_temp_idx]}'
export WANDB_USERNAME='seas'
export WANDB_PROJECT='vmcts'
export WANDB_GROUP='reflexion-sweep-1'
export WANDB_NAME='$run_number/$model_arg_temp'

source ~/.bashrc
conda deactivate
conda activate verify
export PYTHONPATH=.:${PYTHONPATH}
export model_arg_temps=(0.2 0.4 0.6 0.8 1.0)
export model_arg_topp=0.95
export model_arg_topk=0
export token_limit=5000
export run_number=$[$SLURM_ARRAY_TASK_ID/5] # 100 runs per hyperparameter
export hyperparam_number=$[$SLURM_ARRAY_TASK_ID%5]
export model_arg_temp_idx=$[$hyperparam_number]
export model_arg_temp=${model_arg_temps[$model_arg_temp_idx]}
export WANDB_USERNAME=seas
export WANDB_PROJECT=vmcts
export WANDB_GROUP=reflexion-sweep-1
export WANDB_NAME=$run_number/$model_arg_temp
SEED=$run_number
echo Using seed: $SEED
echo Run number: $run_number
echo Temp: $model_arg_temp
echo Top p: $model_arg_topp
python run_reflexion.py --seed=$SEED --use_wandb=True --wandb_entity=$WANDB_USERNAME --wandb_project=$WANDB_PROJECT --wandb_group=$WANDB_GROUP --wandb_name=$WANDB_NAME --remove_hints=True --model_arg_temp=$model_arg_temp --model_arg_topp=$model_arg_topp --model_arg_topk=$model_arg_topk --token_limit=$token_limit
