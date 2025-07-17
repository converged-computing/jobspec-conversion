#!/bin/bash
#FLUX: --job-name=dgr
#FLUX: -n=128
#FLUX: --queue=gpu-a100
#FLUX: -t=5400
#FLUX: --urgency=16

module list
pwd
date
make bssnSolverCtx -j4
ibrun ./BSSN_GR/bssnSolverCtx q1_r2.2.par.json 1
