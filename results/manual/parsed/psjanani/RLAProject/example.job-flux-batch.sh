#!/bin/bash
#FLUX: --job-name=stinky-staircase-5358
#FLUX: --priority=16

set -x  # echo commands to stdout
set -u  # throw an error if unset variable referenced
set -e  # exit on error
PYLON1=/pylon1/$(id -gn)/$USER
PYLON2=/pylon2/$(id -gn)/$USER
module load cuda/8.0
module load python3
pushd $PYLON1
source $PYLON2/my-virtualenv/bin/activate
python $PYLON2/RLAProject/dqn.py --env Breakout-v0
deactivate
popd
