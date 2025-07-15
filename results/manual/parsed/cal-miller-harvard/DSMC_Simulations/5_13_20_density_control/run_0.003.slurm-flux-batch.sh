#!/bin/bash
#FLUX: --job-name=pusheena-dog-2801
#FLUX: --priority=16

echo "running...."
julia RunCells.jl -l 0.003
