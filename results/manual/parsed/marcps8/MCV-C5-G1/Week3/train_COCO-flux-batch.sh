#!/bin/bash
#FLUX --job-name=anxious-staircase-3003
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python coco_retrieval.py
