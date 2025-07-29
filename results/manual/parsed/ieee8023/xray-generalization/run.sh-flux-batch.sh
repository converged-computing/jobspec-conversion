#!/bin/bash
#FLUX --job-name=stinky-cattywampus-2397
#FLUX -t=36000
#FLUX --urgency=16

export LANG='C.UTF-8'

hostname
export LANG=C.UTF-8
source $HOME/.bashrc
python3 -u train-joe.py --threads=8 $@
