#!/bin/bash
#FLUX: --job-name=milky-chair-2932
#FLUX: --urgency=16

spack unload -a
spack load /xi3pch3
spack load py-keras
python3 fb_main.py run P2
