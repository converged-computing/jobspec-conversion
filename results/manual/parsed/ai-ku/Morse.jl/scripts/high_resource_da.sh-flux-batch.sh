#!/bin/bash
#FLUX: --job-name=high_da
#FLUX: --queue=gpu
#FLUX: --urgency=50

echo "julia main.jl --lang da --epochs 100 --dropouts 0.3"
julia main.jl --lang da --epochs 100 --dropouts 0.3
echo "julia main.jl --lang da --epochs 100 --lemma --dropouts 0.3"
julia main.jl --lang da --epochs 100 --lemma --dropouts 0.3
