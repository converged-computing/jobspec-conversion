#!/bin/bash
#FLUX: --job-name=ConvGrainSize
#FLUX: -n=4
#FLUX: --queue=hebbe
#FLUX: -t=10800
#FLUX: --urgency=16

. /apps/new_modules.sh
module load intel
JULIA_PATH=$SNIC_NOBACKUP/julia/
$JULIA_PATH/julia jobrun.jl
