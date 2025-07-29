#!/bin/bash
#FLUX --job-name=dirty-noodle-6179
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python coco_retrieval.py
