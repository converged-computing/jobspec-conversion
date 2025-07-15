#!/bin/bash
#FLUX: --job-name=MAPPO
#FLUX: -c=16
#FLUX: -t=122400
#FLUX: --priority=16

export SC2PATH='/home/memole/projects/def-gdumas85/memole/MPPO-ATTENTIOAN/3rdparty/StarCraftII'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

module load gcc python/3.10 opencv/4.7 mujoco mpi4py
module load scipy-stack
module load rust/1.65.0
DIR=/home/memole//projects/def-gdumas85/memole/MPPO-ATTENTIOAN
source /home/memole/MAPPO/bin/activate
CURRENT_PATH=`pwd`
echo "current path ---> $CURRENT_PATH"
pip install --no-index --upgrade pip
cd /home/memole/projects/def-gdumas85/memole/MPPO-ATTENTIOAN/
pip install -e .
export SC2PATH="/home/memole/projects/def-gdumas85/memole/MPPO-ATTENTIOAN/3rdparty/StarCraftII"
echo "Install Hanabi...."
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
wandb login a2a1bab96ebbc3869c65e3632485e02fcae9cc42
echo "Start running the train_mpe_comm.sh script ..."
cd $DIR/onpolicy/scripts/train
CUDA_VISIBLE_DEVICES=0,1 python train_mpe.py --use_valuenorm --use_popart --env_name "MPE" --algorithm_name "mappo" --experiment_name "check" \
    --scenario_name "simple_speaker_listener" --num_agents 2 --num_landmarks 3 --seed 1 --use_render \
    --n_training_threads 1 --n_rollout_threads 128 --num_mini_batch 1 --episode_length 25 --num_env_steps 2000000 \
    --ppo_epoch 15 --gain 0.01 --lr 7e-4 --critic_lr 7e-4 --use_wandb --user_name "zsheikhb" --wandb_name "zsheikhb" --share_policy
