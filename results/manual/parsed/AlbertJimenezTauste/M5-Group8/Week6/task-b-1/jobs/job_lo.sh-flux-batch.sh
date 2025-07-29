#!/bin/bash
#FLUX --job-name=outstanding-lamp-5539
#FLUX -n=4
#FLUX --queue=mlow
#FLUX --urgency=16

python ../train_clone.py -p mlow
