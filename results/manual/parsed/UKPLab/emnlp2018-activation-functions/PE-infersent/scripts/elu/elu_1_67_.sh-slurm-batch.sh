#!/bin/bash
#FLUX: --job-name=Act_elu_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py elu 1 Adamax 3 0.20543703433054028 51 0.002160465815151414 lecun_uniform PE-infersent 
