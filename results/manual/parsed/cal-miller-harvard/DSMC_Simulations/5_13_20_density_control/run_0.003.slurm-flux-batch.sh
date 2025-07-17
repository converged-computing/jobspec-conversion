#!/bin/bash
#FLUX: --job-name=boopy-hope-7816
#FLUX: -n=8
#FLUX: --queue=shared
#FLUX: -t=480
#FLUX: --urgency=16

echo "running...."
julia RunCells.jl -l 0.003
