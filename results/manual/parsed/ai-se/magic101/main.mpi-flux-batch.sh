#!/bin/bash
#FLUX: --job-name=misunderstood-bicycle-4216
#FLUX: --urgency=16

cd /home/txia4/magic101
source addroot.sh
/home/txia4/anaconda3/bin/python3 Main/experiment.py $1 $2 10
