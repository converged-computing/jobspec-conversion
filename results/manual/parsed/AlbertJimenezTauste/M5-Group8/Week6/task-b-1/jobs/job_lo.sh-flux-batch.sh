#!/bin/bash
#FLUX: --job-name=rainbow-hobbit-9305
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../train_clone.py -p mlow
