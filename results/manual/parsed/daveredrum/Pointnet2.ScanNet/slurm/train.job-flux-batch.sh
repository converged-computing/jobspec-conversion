#!/bin/bash
#FLUX: --job-name=train                           # Job name
#FLUX: --priority=16

date;hostname;pwd
python scripts/train.py --use_multiview --use_normal --tag ssg
