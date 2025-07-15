#!/bin/bash
#FLUX: --job-name=stinky-car-7478
#FLUX: --priority=16

echo "running...."
julia RunCells.jl -l 0.005
