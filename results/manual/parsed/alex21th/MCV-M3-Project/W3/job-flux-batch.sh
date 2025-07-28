#!/bin/bash
#FLUX: --job-name=milky-bits-9167
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python mlp_MIT_8_scene.py
