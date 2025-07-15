#!/bin/bash
#FLUX: --job-name=mpe
#FLUX: -c=42
#FLUX: --queue=small-g
#FLUX: -t=144000
#FLUX: --priority=16

env="MPE"
num_landmarks=3
num_agents=3
algo="rmappo" #"mappo" "ippo"
exp="check"
seed=1
case $SLURM_ARRAY_TASK_ID in
   0)   scenario="simple_spread" ;;
esac
SLURM_CPUS_PER_TASK=42
srun --cpus-per-task=$SLURM_CPUS_PER_TASK singularity run \
--rocm -B $SCRATCH:$SCRATCH \
/scratch/project/docker/mujo_gfoot_env_v2.sif \
/bin/sh -c \
"export PYTHONUSERBASE=/scratch/project/venv_pkgs/mujo_gfoot_env_v2; \
python ./train/train_mpe.py --env_name ${env} --algorithm_name ${algo} --experiment_name ${exp} \
    --scenario_name ${scenario} --num_agents ${num_agents} --num_landmarks ${num_landmarks} --seed ${seed} \
    --n_training_threads 1 --n_rollout_threads 256 --num_mini_batch 1 --episode_length 25 --num_env_steps 20000000 \
    --ppo_epoch 10 --use_ReLU --gain 0.01 --lr 7e-4 --critic_lr 7e-4 --wandb_name "partial_marl" \
    --user_name "partial_marl" --use_eval"
