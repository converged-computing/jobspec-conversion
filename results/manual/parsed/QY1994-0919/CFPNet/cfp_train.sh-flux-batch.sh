#!/bin/bash
#FLUX: --job-name=wobbly-platanos-5192
#FLUX: -c=2
#FLUX: --urgency=16

module load cuda11.0/toolkit/11.0.3
python tools/train.py -f exps/example/custom/cfp_s.py -d 1 -b 16 --fp16 -o -c ./weights/cfp_s.pth
