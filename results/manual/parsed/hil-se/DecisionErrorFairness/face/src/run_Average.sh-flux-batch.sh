#!/bin/bash
#FLUX: --job-name=crunchy-parrot-6445
#FLUX: --priority=16

spack unload -a
spack load /xi3pch3
spack load py-keras
python3 fb_main.py run Average
