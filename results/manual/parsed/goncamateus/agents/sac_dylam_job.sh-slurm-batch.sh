#!/bin/bash
#FLUX: --job-name=sac_dylam_agent
#FLUX: -c=32
#FLUX: --queue=short
#FLUX: --urgency=16

module load Python3.10 Xvfb freeglut glew MuJoCo
source $HOME/.pyvenvs/rl/bin/activate
python run_sac_strat.py --cuda --gym-id $1 --total-timesteps 1000000 --num-envs 16 --track --dylam
