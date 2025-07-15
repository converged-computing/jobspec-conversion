#!/bin/bash
#FLUX: --job-name=muffled-hippo-2616
#FLUX: --urgency=16

python metric_learning.py --arch-type siamese --epochs 200 --process eval
