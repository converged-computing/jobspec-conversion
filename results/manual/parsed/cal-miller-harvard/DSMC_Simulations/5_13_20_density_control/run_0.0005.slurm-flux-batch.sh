#!/bin/bash
#FLUX: --job-name=delicious-citrus-7270
#FLUX: --urgency=16

echo "running...."
julia RunCells.jl -l 0.0005
