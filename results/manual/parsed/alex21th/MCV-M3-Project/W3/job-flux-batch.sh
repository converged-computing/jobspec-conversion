#!/bin/bash
#FLUX --job-name=stanky-latke-7880
#FLUX -n=4
#FLUX --queue=mhigh,mhigh
#FLUX --urgency=16

python mlp_MIT_8_scene.py
