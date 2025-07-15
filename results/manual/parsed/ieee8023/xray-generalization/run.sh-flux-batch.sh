#!/bin/bash
#FLUX: --job-name=stinky-peanut-0723
#FLUX: -t=36000
#FLUX: --priority=16

export LANG='C.UTF-8'

hostname
export LANG=C.UTF-8
source $HOME/.bashrc
python3 -u train-joe.py --threads=8 $@
