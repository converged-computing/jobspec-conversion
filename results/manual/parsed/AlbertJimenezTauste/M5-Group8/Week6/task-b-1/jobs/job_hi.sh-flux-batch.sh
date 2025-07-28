#!/bin/bash
#FLUX: --job-name=carnivorous-malarkey-9208
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python ../train_clone.py -p mhigh
