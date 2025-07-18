#!/bin/bash
#FLUX: --job-name=ddppo
#FLUX: -N=4
#FLUX: -c=10
#FLUX: --gpus-per-task=1
#FLUX: --queue=devlab
#FLUX: -t=259200
#FLUX: --urgency=16

export MAGNUM_LOG='quiet'
export MAGNUM_GPU_VALIDATION='ON'
export LD_LIBRARY_PATH='/usr/lib/x86_64-linux-gnu/nvidia-opengl:${LD_LIBRARY_PATH}'

export MAGNUM_LOG=quiet
export MAGNUM_GPU_VALIDATION=ON
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/nvidia-opengl:${LD_LIBRARY_PATH}
module purge
module load cuda/11.0
module load cudnn/v8.0.3.33-cuda.11.0
module load NCCL/2.7.8-1-cuda.11.0
MAIN_ADDR=$(srun --ntasks=1 hostname 2>&1 | tail -n1)
export MAIN_ADDR
echo $name
set -x
entropy=0.000005
bonus_coef=0.01
ridge=0.1
seed=1
tag=hm3d-noreward-idm-rgbd-bc_${bonus_coef}-entropy_${entropy}-ridge_${ridge}-seed_${seed}
echo $tag
srun python -u -m habitat_baselines.run \
     --exp-config habitat_baselines/config/pointnav/ddppo_pointnav_hm3d.yaml \
     --run-type train TENSORBOARD_DIR data/hm3d/tb/${tag} CHECKPOINT_FOLDER data/hm3d/ckpt/${tag} TASK_CONFIG.SEED ${seed} \
     TRAINER_NAME ddppo-e2b \
     RL.PPO.entropy_coef $entropy \
     RL.E2B.bonus_coef $bonus_coef \
     RL.E2B.ridge $ridge \
     RL.E2B.inv_dynamics_epochs 0 \
     RL.E2B.embedding idm \
     TOTAL_NUM_STEPS 5e8 \
     NUM_UPDATES -1 \
     NUM_CHECKPOINTS 100
