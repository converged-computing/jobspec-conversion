#!/bin/bash
#FLUX --job-name=nerdy-leg-0245
#FLUX -n=8
#FLUX --queue=shared
#FLUX -t=480
#FLUX --urgency=16

echo "running...."
julia RunCells.jl -l 0.0005
