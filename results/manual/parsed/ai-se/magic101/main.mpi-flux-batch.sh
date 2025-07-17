#!/bin/bash
#FLUX: --job-name=OIL
#FLUX: -n=10
#FLUX: -t=75600
#FLUX: --urgency=16

cd /home/txia4/magic101
source addroot.sh
/home/txia4/anaconda3/bin/python3 Main/experiment.py $1 $2 10
