#!/bin/bash
#FLUX: --job-name=misunderstood-bits-9386
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../train_data_aug.py
