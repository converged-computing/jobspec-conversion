#!/bin/bash
#FLUX: --job-name=nav_local
#FLUX: --priority=16

source /etc/profile
module load anaconda/2020a
logs_folder="out_local_global"
mkdir -p $logs_folder
models=("nav_global" "nav_local")
local_obs=("False" "True")
python -u onpolicy/scripts/train_mpe.py --use_valuenorm --use_popart \
--project_name "nav_local_global" \
--env_name "MPE" \
--algorithm_name "rmappo" \
--seed 0 \
--experiment_name "${models[$SLURM_ARRAY_TASK_ID]}" \
--scenario_name "navigation" \
--num_agents=3  --collision_rew 5 \
--n_training_threads 1 --n_rollout_threads 128 \
--num_mini_batch 1 \
--episode_length 25 \
--num_env_steps 2000000 \
--ppo_epoch 10 --use_ReLU --gain 0.01 --lr 7e-4 --critic_lr 7e-4 \
--user_name "marl" \
--local_obs ${local_obs[$SLURM_ARRAY_TASK_ID]} \
--auto_mini_batch_size --target_mini_batch_size 128 \
&> $logs_folder/out_${models[$SLURM_ARRAY_TASK_ID]}
