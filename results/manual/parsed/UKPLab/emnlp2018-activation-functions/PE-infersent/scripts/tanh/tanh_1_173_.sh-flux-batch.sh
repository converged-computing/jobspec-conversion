#!/bin/bash
#FLUX: --job-name=Act_tanh_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py tanh 1 Adadelta 2 0.7018989100321512 268 0.9655957985534902 glorot_normal PE-infersent 
