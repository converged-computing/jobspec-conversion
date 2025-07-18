#!/bin/bash
#FLUX: --job-name=moolicious-cat-9695
#FLUX: -n=17
#FLUX: --queue=gpu
#FLUX: -t=864000
#FLUX: --urgency=16

export DISPLAY=':99.0'

source /etc/profile
module load mpi/openmpi-4.0
module load anaconda/2020a
export DISPLAY=':99.0'
Xvfb :99 -screen 0 1400x900x24 > /dev/null 2>&1 &
mpirun python -B train_a3c.py --env_name CarRacing-v0 --model sac --iter 1 --steps 500000
