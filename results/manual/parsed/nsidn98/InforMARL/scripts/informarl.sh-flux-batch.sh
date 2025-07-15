#!/bin/bash
#FLUX: --job-name=informarl
#FLUX: --urgency=16

source /etc/profile
module load anaconda/2022a
logs_folder="out_informarl7"
mkdir -p $logs_folder
seed_max=5
n_agents=7
ep_lens=(25 50)
for seed in `seq ${seed_max}`;
do
echo "seed: ${seed}"
python -u onpolicy/scripts/train_mpe.py --use_valuenorm --use_popart \
--project_name "compare_${n_agents}" \
--env_name "GraphMPE" \
--algorithm_name "rmappo" \
--seed ${seed} \
--experiment_name "informarl_${ep_lens[$SLURM_ARRAY_TASK_ID]}" \
--scenario_name "navigation_graph" \
--num_agents=${n_agents} \
--collision_rew 5 \
--n_training_threads 1 --n_rollout_threads 128 \
--num_mini_batch 1 \
--episode_length ${ep_lens[$SLURM_ARRAY_TASK_ID]} \
--num_env_steps 5000000 \
--ppo_epoch 10 --use_ReLU --gain 0.01 --lr 7e-4 --critic_lr 7e-4 \
--user_name "marl" \
--use_cent_obs "False" \
--graph_feat_type "relative" \
--auto_mini_batch_size --target_mini_batch_size 128 \
&> $logs_folder/out_${ep_lens[$SLURM_ARRAY_TASK_ID]}_${seed}
done
