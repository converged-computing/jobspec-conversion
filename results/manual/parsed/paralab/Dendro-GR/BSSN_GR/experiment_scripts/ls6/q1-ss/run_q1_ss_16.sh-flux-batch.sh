#!/bin/bash
#FLUX: --job-name=dgr
#FLUX: -N=8
#FLUX: -n=16
#FLUX: --queue=gpu-a100
#FLUX: -t=5400
#FLUX: --urgency=16

module list
pwd
date
make bssnSolverCUDA -j4
ibrun ./BSSN_GR/bssnSolverCUDA q1_r2.2.par.json 1
