#!/bin/bash
#FLUX: --job-name=peachy-despacito-6819
#FLUX: --queue=Quick
#FLUX: --urgency=16

conda activate semParse2
python3 /home/d/dvitel/semp/ge.py "$@"
