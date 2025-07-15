#!/bin/bash
#FLUX: --job-name=sac_agent
#FLUX: --priority=16

module load Python3.10 Xvfb freeglut glew MuJoCo
source $HOME/.pyvenvs/rl/bin/activate
python run_sac.py --cuda --gym-id $1 --total-timesteps 1000000 --num-envs 16 --track
