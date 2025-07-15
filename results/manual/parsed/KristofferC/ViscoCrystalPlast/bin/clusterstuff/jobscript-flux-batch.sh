#!/bin/bash
#FLUX: --job-name=placid-underoos-8151
#FLUX: --priority=16

. /apps/new_modules.sh
module load intel
JULIA_PATH=$SNIC_NOBACKUP/julia/
$JULIA_PATH/julia jobrun.jl
