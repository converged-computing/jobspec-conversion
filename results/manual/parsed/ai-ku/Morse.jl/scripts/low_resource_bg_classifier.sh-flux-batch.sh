#!/bin/bash
#FLUX: --job-name=low_bg_classifer
#FLUX: --queue=gpu
#FLUX: --urgency=16

echo "julia main.jl --lang bg --epochs 100 --dropouts 0.5 --modelType Classifier --optimizer 'Rmsprop(lr=1.0e-3, gclip=60)'"
julia main.jl --lang bg --epochs 100 --dropouts 0.5 --modelType Classifier --optimizer 'Rmsprop(lr=1.0e-3, gclip=60)'
