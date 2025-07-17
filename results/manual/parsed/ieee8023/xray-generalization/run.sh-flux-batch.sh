#!/bin/bash
#FLUX: --job-name=cowy-general-2514
#FLUX: -t=36000
#FLUX: --urgency=16

export LANG='C.UTF-8'

hostname
export LANG=C.UTF-8
source $HOME/.bashrc
python3 -u train-joe.py --threads=8 $@
