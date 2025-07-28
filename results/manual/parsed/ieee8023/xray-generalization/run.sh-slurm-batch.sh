#!/bin/bash
#FLUX: --job-name=crunchy-carrot-8941
#FLUX: -t=36000
#FLUX: --urgency=16

export LANG='C.UTF-8'

hostname
export LANG=C.UTF-8
source $HOME/.bashrc
python3 -u train-joe.py --threads=8 $@
