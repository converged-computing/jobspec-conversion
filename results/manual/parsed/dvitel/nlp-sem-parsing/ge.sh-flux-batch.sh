#!/bin/bash
#FLUX: --job-name=phat-lettuce-6684
#FLUX: --queue=Quick
#FLUX: --urgency=16

conda activate semParse2
python3 /home/d/dvitel/semp/ge.py "$@"
