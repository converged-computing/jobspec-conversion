#!/bin/bash
#FLUX --job-name=eccentric-rabbit-4357
#FLUX -n=4
#FLUX --queue=mlow
#FLUX --urgency=16

python ~/datasets/Cityscapes/build_cityscapes_data.py -p mlow
