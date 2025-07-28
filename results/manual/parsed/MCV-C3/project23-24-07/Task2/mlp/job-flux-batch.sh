#!/bin/bash
#FLUX: --job-name=astute-squidward-7841
#FLUX: -n=4
#FLUX: --queue=mhigh,mhigh
#FLUX: --urgency=16

python patch_based_mlp_MIT_8_scene.py $1
