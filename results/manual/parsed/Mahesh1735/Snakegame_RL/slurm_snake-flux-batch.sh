#!/bin/bash
#FLUX: --job-name=salted-cattywampus-7553
#FLUX: --queue=standard
#FLUX: -t=5340
#FLUX: --urgency=16

nproc
sleep 1
module load cuda75/toolkit/7.5.18
source /home/s.aakhil/snake_env/bin/activate
ipython /home/s.aakhil/snakegame/ddqn.py
