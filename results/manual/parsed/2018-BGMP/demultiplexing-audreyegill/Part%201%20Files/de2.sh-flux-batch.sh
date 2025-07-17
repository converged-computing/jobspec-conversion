#!/bin/bash
#FLUX: --job-name=DM_2
#FLUX: --queue=short
#FLUX: -t=600
#FLUX: --urgency=16

ml easybuild intel/2017a Python/3.6.1
./pt_one2.py
