#!/bin/bash
#FLUX: --job-name=dgr
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --queue=gpu-a100
#FLUX: -t=5400
#FLUX: --urgency=16

module list
pwd
date
make bssnWSTestCUDA -j4
ibrun ./BSSN_GR/bssnWSTestCUDA q1_ws.par.json 1
