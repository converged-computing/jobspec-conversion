#!/bin/bash
#FLUX --job-name=scruptious-eagle-4490
#FLUX -n=8
#FLUX --queue=shared
#FLUX -t=480
#FLUX --urgency=16

echo "running...."
julia RunCells.jl -l 0.0095
