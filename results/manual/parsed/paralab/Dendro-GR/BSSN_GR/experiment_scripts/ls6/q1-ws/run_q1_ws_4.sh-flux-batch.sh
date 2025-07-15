#!/bin/bash
#FLUX: --job-name=persnickety-lemon-9596
#FLUX: --urgency=16

module list
pwd
date
make bssnWSTestCUDA -j4
ibrun ./BSSN_GR/bssnWSTestCUDA q1_ws.par.json 1
