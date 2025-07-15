#!/bin/bash
#FLUX: --job-name=ppo_agent
#FLUX: --priority=16

module load Python3.10 Xvfb freeglut glew MuJoCo
source $HOME/.pyvenvs/rl/bin/activate
xvfb-run -a python run_ppo.py --cuda --gym-id $1 --total-timesteps 1000000 \
    --capture-video --num-envs 16 --track --video-freq 10
