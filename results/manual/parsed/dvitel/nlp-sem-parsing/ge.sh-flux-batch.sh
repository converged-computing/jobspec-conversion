#!/bin/bash
#FLUX: --job-name=gassy-omelette-6085
#FLUX: --urgency=16

conda activate semParse2
python3 /home/d/dvitel/semp/ge.py "$@"
