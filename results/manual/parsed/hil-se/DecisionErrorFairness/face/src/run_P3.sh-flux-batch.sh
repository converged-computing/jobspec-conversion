#!/bin/bash
#FLUX: --job-name=scut_face
#FLUX: --queue=tier3
#FLUX: -t=86400
#FLUX: --urgency=16

spack unload -a
spack load /xi3pch3
spack load py-keras
python3 fb_main.py run P3
