#!/bin/bash
#FLUX: --job-name=hairy-malarkey-7987
#FLUX: -n=8
#FLUX: --queue=shared
#FLUX: -t=480
#FLUX: --urgency=16

echo "running...."
julia RunCells.jl -l 0.003
