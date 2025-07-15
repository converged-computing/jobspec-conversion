#!/bin/bash
#FLUX: --job-name=cent_obs_3
#FLUX: --priority=16

source /etc/profile
module load anaconda/2020a
n_agents=3
logs_folder="out_cent_obs_3"
mkdir -p $logs_folder
models=("graph_3_cent_obs" "graph_3_no_cent_obs")
cent_obs=("True" "False")
seeds=(0)
episode_lengths=(25)
args_models=()
args_cent_obs=()
args_seeds=()
args_ep_lengths=()
for i in ${!models[@]}; do
    for j in ${!seeds[@]}; do
        for k in ${!episode_lengths[@]}; do
            args_models+=(${models[$i]})
            args_cent_obs+=(${cent_obs[$i]})
            args_seeds+=(${seeds[$j]})
            args_ep_lengths+=(${episode_lengths[$k]})
        done
    done
done
python -u onpolicy/scripts/train_mpe.py --use_valuenorm --use_popart \
--project_name "cent_obs_3" \
--env_name "GraphMPE" \
--algorithm_name "rmappo" \
--seed "${args_seeds[$SLURM_ARRAY_TASK_ID]}" \
--experiment_name "${args_models[$SLURM_ARRAY_TASK_ID]}_${args_ep_lengths[$SLURM_ARRAY_TASK_ID]}" \
--scenario_name "navigation_graph" \
--num_agents=${n_agents} \
--n_training_threads 1 --n_rollout_threads 128 \
--num_mini_batch 1 \
--episode_length ${args_ep_lengths[$SLURM_ARRAY_TASK_ID]} \
--num_env_steps 2000000 \
--ppo_epoch 10 --use_ReLU --gain 0.01 --lr 7e-4 --critic_lr 7e-4 \
--user_name "marl" \
--use_cent_obs ${args_cent_obs[$SLURM_ARRAY_TASK_ID]} \
--auto_mini_batch_size --target_mini_batch_size 128 \
&> $logs_folder/out_${args_models[$SLURM_ARRAY_TASK_ID]}_${args_ep_lengths[$SLURM_ARRAY_TASK_ID]}_${args_seeds[$SLURM_ARRAY_TASK_ID]}
