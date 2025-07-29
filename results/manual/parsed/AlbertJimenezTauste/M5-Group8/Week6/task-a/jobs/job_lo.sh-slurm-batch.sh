#!/bin/bash
#FLUX: --job-name=cowy-knife-3799
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ../train_data_aug.py
