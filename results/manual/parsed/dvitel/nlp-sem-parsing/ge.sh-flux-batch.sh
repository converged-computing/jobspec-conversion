#!/bin/bash
#FLUX --job-name=sticky-lizard-4862
#FLUX --queue=Quick
#FLUX --urgency=16

conda activate semParse2
python3 /home/d/dvitel/semp/ge.py "$@"
