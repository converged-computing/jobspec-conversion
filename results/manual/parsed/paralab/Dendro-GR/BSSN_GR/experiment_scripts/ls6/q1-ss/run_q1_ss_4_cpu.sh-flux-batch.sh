#!/bin/bash
#FLUX: --job-name=purple-leader-0206
#FLUX: --priority=16

module list
pwd
date
make bssnSolverCtx -j4
ibrun ./BSSN_GR/bssnSolverCtx q1_r2.2.par.json 1
