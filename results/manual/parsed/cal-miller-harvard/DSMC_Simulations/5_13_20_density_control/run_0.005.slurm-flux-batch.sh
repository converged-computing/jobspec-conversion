#!/bin/bash
#FLUX: --job-name=fuzzy-peanut-3772
#FLUX: --urgency=16

echo "running...."
julia RunCells.jl -l 0.005
