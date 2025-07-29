#!/bin/bash
#FLUX --job-name=grated-dog-4050
#FLUX -n=4
#FLUX --queue=mlow
#FLUX --urgency=16

python ../train_data_aug.py
