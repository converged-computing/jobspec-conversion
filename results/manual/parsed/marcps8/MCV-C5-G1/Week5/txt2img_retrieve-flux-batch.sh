#!/bin/bash
#FLUX: --job-name=peachy-lemon-6349
#FLUX: -n=8
#FLUX: --queue=mlow,mlow
#FLUX: --urgency=16

python txt2img_retrieve.py
