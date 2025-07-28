#!/bin/bash
#FLUX: --job-name=milky-lettuce-6844
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../train_data_aug.py
