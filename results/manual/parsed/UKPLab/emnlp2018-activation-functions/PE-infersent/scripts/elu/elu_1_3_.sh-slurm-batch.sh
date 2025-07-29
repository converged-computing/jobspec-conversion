#!/bin/bash
#FLUX: --job-name=Act_elu_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py elu 1 RMSprop 1 0.48032731930799355 328 0.0012148783804246386 he_uniform PE-infersent 
