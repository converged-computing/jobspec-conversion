#!/bin/bash
#FLUX: --job-name=gloopy-citrus-3786
#FLUX: --urgency=16

spack unload -a
spack load /xi3pch3
spack load py-keras
python3 fb_main.py run P1
