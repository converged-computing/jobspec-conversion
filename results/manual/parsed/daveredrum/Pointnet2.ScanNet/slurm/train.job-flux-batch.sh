#!/bin/bash
#FLUX: --job-name=train
#FLUX: --queue=normal
#FLUX: --urgency=16

date;hostname;pwd
python scripts/train.py --use_multiview --use_normal --tag ssg
