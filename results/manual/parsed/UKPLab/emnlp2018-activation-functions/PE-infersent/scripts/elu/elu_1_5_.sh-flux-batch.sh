#!/bin/bash
#FLUX: --job-name=Act_elu_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py elu 1 Nadam 2 0.5803886732447463 66 0.002284018840772878 glorot_uniform PE-infersent 
