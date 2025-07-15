#!/bin/bash
#FLUX: --job-name=conspicuous-peas-6422
#FLUX: --priority=16

module list
pwd
date
make bssnWSTestCUDA -j4
ibrun ./BSSN_GR/bssnWSTestCUDA q1_ws.par.json 1
