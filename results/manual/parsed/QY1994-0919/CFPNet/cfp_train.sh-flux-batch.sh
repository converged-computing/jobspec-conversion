#!/bin/bash
#FLUX: --job-name=train
#FLUX: -c=2
#FLUX: --queue=defq
#FLUX: -t=691200
#FLUX: --urgency=16

module load cuda11.0/toolkit/11.0.3
python tools/train.py -f exps/example/custom/cfp_s.py -d 1 -b 16 --fp16 -o -c ./weights/cfp_s.pth
