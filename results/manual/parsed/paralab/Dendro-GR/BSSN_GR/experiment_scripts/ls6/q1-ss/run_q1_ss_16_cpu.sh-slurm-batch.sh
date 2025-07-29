#!/bin/bash
#FLUX: --job-name=dgr
#FLUX: -N=8
#FLUX: -n=1024
#FLUX: --queue=normal
#FLUX: -t=5400
#FLUX: --urgency=16

module list
pwd
date
make bssnSolverCtx -j4
ibrun ./BSSN_GR/bssnSolverCtx q1_r2.2.par.json 1
