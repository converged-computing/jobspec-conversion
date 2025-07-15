#!/bin/bash
#FLUX: --job-name=marl_7_compare
#FLUX: --urgency=16

source /etc/profile
module load anaconda/2020a
n_agents=7
env_names=("GraphMPE")
scenarios=("navigation_graph")
models=("graph_7")
seeds=(0)
episode_lengths=(25 50 100)
args_models=()
args_env_names=()
args_scenarios=()
args_seeds=()
args_ep_lengths=()
for i in ${!models[@]}; do
    for j in ${!seeds[@]}; do
        for k in ${!episode_lengths[@]}; do
            args_models+=(${models[$i]})
            args_env_names+=(${env_names[$i]})
            args_scenarios+=(${scenarios[$i]})
            args_seeds+=(${seeds[$j]})
            args_ep_lengths+=(${episode_lengths[$k]})
        done
    done
done
python -u onpolicy/scripts/train_mpe.py --use_valuenorm --use_popart \
--project_name "compare_7" \
--env_name "${args_env_names[$SLURM_ARRAY_TASK_ID]}" \
--algorithm_name "rmappo" \
--seed "${args_seeds[$SLURM_ARRAY_TASK_ID]}" \
--experiment_name "${args_models[$SLURM_ARRAY_TASK_ID]}_${args_ep_lengths[$SLURM_ARRAY_TASK_ID]}" \
--scenario_name "${args_scenarios[$SLURM_ARRAY_TASK_ID]}" \
--num_agents=${n_agents} \
--n_training_threads 1 --n_rollout_threads 128 \
--num_mini_batch 1 \
--episode_length ${args_ep_lengths[$SLURM_ARRAY_TASK_ID]} \
--num_env_steps 20000000 \
--ppo_epoch 10 --use_ReLU --gain 0.01 --lr 7e-4 --critic_lr 7e-4 \
--user_name "marl" \
--auto_mini_batch_size
