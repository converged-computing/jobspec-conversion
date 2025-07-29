#!/bin/bash
#FLUX: --job-name=salted-butter-7641
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python coco_retrieval.py
