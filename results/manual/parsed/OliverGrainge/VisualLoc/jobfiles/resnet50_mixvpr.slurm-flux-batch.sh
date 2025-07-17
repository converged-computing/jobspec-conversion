#!/bin/bash
#FLUX: --job-name=resnet50_mixvpr
#FLUX: -c=16
#FLUX: --queue=a100
#FLUX: --urgency=16

python train.py --method resnet50_mixvpr --image_resolution 320 320
