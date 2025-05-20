#!/bin/bash

#FLUX: --job-name=@[JBNME]
#FLUX: --time-limit=45m
#FLUX: --queue=@[QUEUE]
#FLUX: --account=GFS-DEV
#FLUX: -N 1
#FLUX: -n 1
#FLUX: --cores-per-task=1
#FLUX: --mem-per-task=8192M
#FLUX: --output=out
#FLUX: --error=err

set -eux

echo "Compile started:  " `date`

@[PATHRT]/compile_cmake.sh @[PATHTR] @[MACHINE_ID] "@[MAKE_OPT]" @[COMPILE_NR]

echo "Compile ended:    " `date`