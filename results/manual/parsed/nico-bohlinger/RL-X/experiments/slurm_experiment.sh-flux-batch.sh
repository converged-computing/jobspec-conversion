#!/bin/bash
#FLUX: --job-name=rlx_experiment
#FLUX: -t=1800
#FLUX: --urgency=16

eval "$(/home/bohlinger/miniconda3/bin/conda shell.bash hook)"
conda activate rlx
python experiment.py \
    --algorithm.name="ppo.pytorch" \
    --algorithm.total_timesteps=10000 \
    --environment.name="gym.mujoco.humanoid_v4" \
    --environment.nr_envs=1 \
    --environment.seed=0 \
    --runner.mode="train" \
    --runner.track_console=False \
    --runner.track_tb=True \
    --runner.track_wandb=True \
    --runner.save_model=True \
    --runner.wandb_entity="placeholder" \
    --runner.project_name="placeholder" \
    --runner.exp_name="placeholder" \
    --runner.notes="placeholder"
