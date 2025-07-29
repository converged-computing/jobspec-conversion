#!/bin/bash
#FLUX --job-name=blank-bicycle-9277
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python ../train_clone.py -p mhigh
