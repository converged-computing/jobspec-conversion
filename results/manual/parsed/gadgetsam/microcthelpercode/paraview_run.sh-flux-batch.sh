#!/bin/bash
#FLUX: --job-name=expressive-platanos-0483
#FLUX: -t=60
#FLUX: --urgency=16

module load ParaView
start_pvbatch.sh 1 1 haswell 00:1:00 default debug `pwd`/pv-test.py
