#!/bin/bash
#FLUX: --job-name=lovable-bicycle-5384
#FLUX: -n=8
#FLUX: --queue=shared
#FLUX: -t=480
#FLUX: --urgency=16

echo "running...."
julia RunCells.jl -l 0.001
