#!/bin/bash
#FLUX: --job-name=Act_elu_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py elu 1 Adamax 2 0.2970755532931561 171 0.001799642701972302 he_uniform PE-infersent 
