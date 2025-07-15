#!/bin/bash
#FLUX: --job-name=lovable-cinnamonbun-1401
#FLUX: --queue=amd
#FLUX: -t=1800
#FLUX: --urgency=16

export LANG='C'

module load intel
module load R
export LANG=C
R --vanilla -f testdopar.R
