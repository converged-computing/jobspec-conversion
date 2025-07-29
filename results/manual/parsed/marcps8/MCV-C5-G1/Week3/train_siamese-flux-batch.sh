#!/bin/bash
#FLUX --job-name=moolicious-kerfuffle-6488
#FLUX -n=4
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python metric_learning.py --arch-type siamese --epochs 200 --process eval
