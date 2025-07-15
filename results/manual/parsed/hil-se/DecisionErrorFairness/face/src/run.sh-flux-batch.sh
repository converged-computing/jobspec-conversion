#!/bin/bash
#FLUX: --job-name=crunchy-peanut-1105
#FLUX: --urgency=16

spack unload -a
spack load /xi3pch3
spack load py-keras
python3 main.py
