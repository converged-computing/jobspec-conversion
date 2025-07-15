#!/bin/bash
#FLUX: --job-name=lovely-diablo-5891
#FLUX: --urgency=16

echo "running...."
julia RunCells.jl -l 0.001
