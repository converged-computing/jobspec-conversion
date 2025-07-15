#!/bin/bash
#FLUX: --job-name=fat-nalgas-0505
#FLUX: --priority=16

echo "running...."
julia RunCells.jl -l 0.0005
