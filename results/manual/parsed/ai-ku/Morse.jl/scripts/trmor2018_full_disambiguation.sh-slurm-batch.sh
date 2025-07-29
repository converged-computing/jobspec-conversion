#!/bin/bash
#FLUX: --job-name=trmor2006_full_dis
#FLUX: --queue=ai
#FLUX: -t=201600
#FLUX: --urgency=16

echo "julia main.jl --dataSet TRDataSet --version 2018 --epochs 100 --lemma --dropouts 0.3 --modelType MorseDis"
julia main.jl --dataSet TRDataSet --version 2018 --epochs 100 --lemma --dropouts 0.3 --modelType MorseDis
