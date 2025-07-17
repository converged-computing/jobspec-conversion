#!/bin/bash
#FLUX: --job-name=hddqn_agent
#FLUX: -c=32
#FLUX: --urgency=16

module use /opt/easybuild/modules/all/
module load Python3.10 Xvfb freeglut glew MuJoCo
source $HOME/.pyvenvs/rl/bin/activate
python run_hdddqn.py --cuda --gym-id $1 --total-timesteps 1000000 --capture-video --track --update-freq 5 --pre-train-steps 50000
