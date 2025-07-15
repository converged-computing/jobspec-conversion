#!/bin/bash
#FLUX: --job-name=nerdy-bike-5850
#FLUX: --urgency=16

echo "running...."
julia RunCells.jl -l 0.009
