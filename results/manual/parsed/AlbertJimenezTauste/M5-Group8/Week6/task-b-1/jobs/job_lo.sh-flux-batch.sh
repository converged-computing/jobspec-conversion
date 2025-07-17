#!/bin/bash
#FLUX: --job-name=gloopy-toaster-6468
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../train_clone.py -p mlow
