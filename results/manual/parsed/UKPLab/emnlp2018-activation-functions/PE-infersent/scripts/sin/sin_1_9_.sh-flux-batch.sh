#!/bin/bash
#FLUX: --job-name=Act_sin_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py sin 1 Adagrad 2 0.2523016050324485 269 0.012141442228539474 lecun_uniform PE-infersent 
