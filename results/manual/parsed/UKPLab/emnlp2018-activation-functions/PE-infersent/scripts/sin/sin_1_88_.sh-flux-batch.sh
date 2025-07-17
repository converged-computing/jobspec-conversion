#!/bin/bash
#FLUX: --job-name=Act_sin_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py sin 1 Adadelta 1 0.3799096775332562 260 1.0653056843847277 varscaling PE-infersent 
