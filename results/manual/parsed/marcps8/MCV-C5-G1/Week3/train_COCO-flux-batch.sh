#!/bin/bash
#FLUX: --job-name=misunderstood-train-3908
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python coco_retrieval.py
