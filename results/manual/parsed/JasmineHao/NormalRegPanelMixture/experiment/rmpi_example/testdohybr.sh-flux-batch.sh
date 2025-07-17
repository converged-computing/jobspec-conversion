#!/bin/bash
#FLUX: --job-name=job
#FLUX: -c=20
#FLUX: --queue=amd
#FLUX: -t=1800
#FLUX: --urgency=16

export LANG='C'

module load intel
module load R
export LANG=C
time mpirun R --vanilla -f testhybr.R
