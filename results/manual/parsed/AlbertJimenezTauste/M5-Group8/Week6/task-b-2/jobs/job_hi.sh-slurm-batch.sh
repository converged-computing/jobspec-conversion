#!/bin/bash
#FLUX: --job-name=chocolate-house-2224
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python ../train_synth.py -p mhigh
