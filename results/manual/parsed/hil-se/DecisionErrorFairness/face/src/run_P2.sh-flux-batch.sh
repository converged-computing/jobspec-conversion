#!/bin/bash
#FLUX: --job-name=carnivorous-sundae-7702
#FLUX: --priority=16

spack unload -a
spack load /xi3pch3
spack load py-keras
python3 fb_main.py run P2
