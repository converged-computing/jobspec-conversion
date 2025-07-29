#!/bin/bash
#FLUX: --job-name=Act_elu_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py elu 1 Adagrad 3 0.7436914144374638 102 0.007368237071611118 orth PE-infersent 
