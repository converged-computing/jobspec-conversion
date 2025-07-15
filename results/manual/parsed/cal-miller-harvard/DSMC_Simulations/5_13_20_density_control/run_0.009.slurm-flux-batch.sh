#!/bin/bash
#FLUX: --job-name=red-avocado-0002
#FLUX: --priority=16

echo "running...."
julia RunCells.jl -l 0.009
