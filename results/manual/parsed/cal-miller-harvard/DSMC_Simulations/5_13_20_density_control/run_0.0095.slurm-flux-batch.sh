#!/bin/bash
#FLUX: --job-name=gassy-carrot-4197
#FLUX: --priority=16

echo "running...."
julia RunCells.jl -l 0.0095
