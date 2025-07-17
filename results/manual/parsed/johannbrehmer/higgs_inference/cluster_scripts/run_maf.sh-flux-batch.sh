#!/bin/bash
#FLUX: --job-name=higgsmaf
#FLUX: -t=604800
#FLUX: --urgency=16

source activate goldmine
cd /home/jb6504/higgs_inference/higgs_inference
python -u experiments.py maf -o short
