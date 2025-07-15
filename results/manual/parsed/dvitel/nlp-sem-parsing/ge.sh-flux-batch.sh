#!/bin/bash
#FLUX: --job-name=confused-cat-3915
#FLUX: --priority=16

conda activate semParse2
python3 /home/d/dvitel/semp/ge.py "$@"
