#!/bin/bash
#FLUX: --job-name=mcts-testing
#FLUX: -c=4
#FLUX: --queue=gpu_requeue
#FLUX: -t=86400
#FLUX: --urgency=16

export PYTHONPATH='.:${PYTHONPATH}'
export discovery_factors='(0.1 0.3 1.0)'
export widen_policy_values='(0.1 0.2 0.5)'
export run_number='$[$SLURM_ARRAY_TASK_ID/9]'
export hyperparam_number='$[$SLURM_ARRAY_TASK_ID%9]'
export discovery_here_idx='$[$hyperparam_number%3]'
export widen_here_idx='$[$hyperparam_number/3]'
export discovery_here='${discovery_factors[$discovery_here_idx]}'
export widen_here='${widen_policy_values[$widen_here_idx]}'
export WANDB_USERNAME='seas'
export WANDB_PROJECT='vmcts'
export WANDB_GROUP='exploration-sweep'
export WANDB_NAME='$run_number/$discovery_here/$widen_here'

source ~/.bashrc
conda deactivate
conda activate llm-verified
export PYTHONPATH=.:${PYTHONPATH}
export discovery_factors=(0.1 0.3 1.0)
export widen_policy_values=(0.1 0.2 0.5)
export run_number=$[$SLURM_ARRAY_TASK_ID/9]
export hyperparam_number=$[$SLURM_ARRAY_TASK_ID%9]
export discovery_here_idx=$[$hyperparam_number%3]
export widen_here_idx=$[$hyperparam_number/3]
export discovery_here=${discovery_factors[$discovery_here_idx]}
export widen_here=${widen_policy_values[$widen_here_idx]}
export WANDB_USERNAME=seas
export WANDB_PROJECT=vmcts
export WANDB_GROUP=exploration-sweep
export WANDB_NAME=$run_number/$discovery_here/$widen_here
SEED=$RANDOM
echo Using seed: $SEED
echo Run number: $run_number
echo Discovery factor: $discovery_here
echo Widen policy value: $widen_here
python run_intermediate_expansion.py --seed=$SEED --use_wandb=True --wandb_entity=$WANDB_USERNAME --wandb_project=$WANDB_PROJECT --wandb_group=$WANDB_GROUP --wandb_name=$WANDB_NAME --widen_policy_value=$widen_here --discovery_factor=$discovery_here
