#!/bin/bash
#FLUX: --job-name=ornery-salad-0768
#FLUX: --urgency=16

. /apps/new_modules.sh
module load intel
JULIA_PATH=$SNIC_NOBACKUP/julia/
$JULIA_PATH/julia jobrun.jl
