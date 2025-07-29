#!/bin/bash
#FLUX: --job-name=Act_elu_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py elu 1 RMSprop 2 0.5394407940012951 293 0.0005872644578229275 varscaling PE-infersent 
