#!/bin/bash
#FLUX: --job-name=mappo_opt
#FLUX: -c=40
#FLUX: --queue=batch
#FLUX: -t=144000
#FLUX: --urgency=16

export PYTHONUSERBASE='/scratch/work/zhaow7/PycharmProjects/docker/mappo_env \'

env="mujoco"
scenario="HalfCheetah-v2"
agent_conf="6x1"
agent_obsk=0
algo="mappo_swish" 
case $SLURM_ARRAY_TASK_ID in
   0)  beta=0.1 ;;
   1)  beta=0.5 ;;
   2)  beta=1.0 ;;
   3)  beta=2.0 ;;
esac
echo "env is ${env}, scenario is ${scenario}, agent_conf is ${agent_conf}, algo is ${algo}"
CUDA_VISIBLE_DEVICES=0 singularity exec --bind /scratch --nv /scratch/work/zhaow7/mujoco_football_nvidia.sif /bin/sh -c \
"export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/scratch/work/zhaow7/mujoco/mujoco210 \
export PYTHONUSERBASE=/scratch/work/zhaow7/PycharmProjects/docker/mappo_env \
python ./train/train_mujoco_1.py \
--use_recurrent_policy --num_mini_batch 40 --env_name ${env} --scenario_name ${scenario} --agent_conf ${agent_conf}\
                                    --agent_obsk 2 --lr 0.00005 --critic_lr 0.005 --n_training_thread 32 --n_rollout_threads 32 --num_env_steps 40000000 \
                                    --episode_length 1000 --ppo_epoch 5 --algorithm_name ${algo} --wandb_tag "rebuttal" --use_recurrent_policy --use_eval \
                                    --eval_interval 10 --n_eval_rollout_threads 1 --swish_beta ${beta} --share_policy"
