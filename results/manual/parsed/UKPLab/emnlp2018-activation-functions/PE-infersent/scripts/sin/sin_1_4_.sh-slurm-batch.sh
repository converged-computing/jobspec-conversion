#!/bin/bash
#FLUX: --job-name=Act_sin_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py sin 1 sgd 3 0.6809656631932558 237 0.011851763868027906 glorot_uniform PE-infersent 
