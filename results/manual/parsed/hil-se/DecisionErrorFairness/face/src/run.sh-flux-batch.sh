#!/bin/bash
#FLUX: --job-name=dinosaur-caramel-2965
#FLUX: --priority=16

spack unload -a
spack load /xi3pch3
spack load py-keras
python3 main.py
