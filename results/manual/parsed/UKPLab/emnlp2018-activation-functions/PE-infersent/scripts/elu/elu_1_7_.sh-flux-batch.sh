#!/bin/bash
#FLUX: --job-name=Act_elu_1
#FLUX: -t=86340
#FLUX: --urgency=16

python3 /home/se55gyhe/Act_func/progs/meta.py elu 1 Adadelta 4 0.7478255172813804 450 0.7832244981547475 glorot_uniform PE-infersent 
