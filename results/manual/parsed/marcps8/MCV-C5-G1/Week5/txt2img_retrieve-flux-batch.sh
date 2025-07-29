#!/bin/bash
#FLUX --job-name=pusheena-bike-8547
#FLUX -n=8
#FLUX --queue=mlow,mlow
#FLUX --urgency=16

python txt2img_retrieve.py
