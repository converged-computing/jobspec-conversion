#!/bin/bash
#FLUX: --job-name=wobbly-blackbean-8160
#FLUX: -n=4
#FLUX: --queue=mlow
#FLUX: --urgency=16

python ~/datasets/Cityscapes/build_cityscapes_data.py -p mlow
