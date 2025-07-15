#!/bin/bash
#FLUX: --job-name=frigid-bike-8137
#FLUX: --urgency=16

echo "running...."
julia RunCells.jl -l 0.0095
