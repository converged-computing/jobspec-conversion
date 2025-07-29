#!/bin/bash
#FLUX --job-name=peachy-citrus-4608
#FLUX -n=4
#FLUX --queue=mlow
#FLUX --urgency=16

python ../train_data_aug.py
