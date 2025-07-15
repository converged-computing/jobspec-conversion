#!/bin/bash
#FLUX: --job-name=joyous-taco-4797
#FLUX: --urgency=16

spack unload -a
spack load /lklqe3u
spack load /saj4vss
spack load py-pandas
python3 main.py nofair 10
