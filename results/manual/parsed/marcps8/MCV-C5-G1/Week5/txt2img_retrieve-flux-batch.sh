#!/bin/bash
#FLUX --job-name=hanky-diablo-7344
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python txt2img_retrieve.py
