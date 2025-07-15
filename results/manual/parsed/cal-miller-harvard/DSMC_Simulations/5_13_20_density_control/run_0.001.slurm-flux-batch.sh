#!/bin/bash
#FLUX: --job-name=bloated-destiny-8335
#FLUX: --priority=16

echo "running...."
julia RunCells.jl -l 0.001
