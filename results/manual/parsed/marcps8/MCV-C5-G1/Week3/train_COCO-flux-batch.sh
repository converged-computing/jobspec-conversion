#!/bin/bash
#FLUX: --job-name=chunky-latke-7276
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python coco_retrieval.py
