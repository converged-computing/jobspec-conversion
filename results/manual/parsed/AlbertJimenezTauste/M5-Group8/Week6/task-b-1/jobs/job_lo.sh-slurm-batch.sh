#!/bin/bash
#FLUX: --job-name=dinosaur-cattywampus-1205
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../train_clone.py -p mlow
