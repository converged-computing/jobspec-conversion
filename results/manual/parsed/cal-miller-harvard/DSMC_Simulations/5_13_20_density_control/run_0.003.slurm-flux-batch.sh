#!/bin/bash
#FLUX: --job-name=reclusive-bits-5030
#FLUX: --urgency=16

echo "running...."
julia RunCells.jl -l 0.003
