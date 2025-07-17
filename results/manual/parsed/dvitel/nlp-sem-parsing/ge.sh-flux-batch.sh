#!/bin/bash
#FLUX: --job-name=carnivorous-dog-8121
#FLUX: --queue=Quick
#FLUX: --urgency=16

conda activate semParse2
python3 /home/d/dvitel/semp/ge.py "$@"
