#!/bin/bash
#FLUX: --job-name=arid-nunchucks-7639
#FLUX: --priority=16

module list
pwd
date
make bssnSolverCUDA -j4
ibrun ./BSSN_GR/bssnSolverCUDA q1_r2.2.par.json 1
