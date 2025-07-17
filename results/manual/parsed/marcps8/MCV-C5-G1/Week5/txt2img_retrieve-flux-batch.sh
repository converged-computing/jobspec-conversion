#!/bin/bash
#FLUX: --job-name=hairy-chip-3284
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python txt2img_retrieve.py
