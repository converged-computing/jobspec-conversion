#!/bin/bash
#FLUX: --job-name=rlearning_orbit
#FLUX: -c=6
#FLUX: --queue=gengpu
#FLUX: -t=172800
#FLUX: --priority=16

source /opt/flight/etc/setup.sh
flight env activate gridware
module load libs/nvidia-cuda/11.2.0/bin
python3 src/do_reinforcement_learning_runs.py
