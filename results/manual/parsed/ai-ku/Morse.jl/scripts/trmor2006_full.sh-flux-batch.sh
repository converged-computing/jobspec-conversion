#!/bin/bash
#FLUX: --job-name=trmor2006_full
#FLUX: --queue=ai
#FLUX: -t=201600
#FLUX: --urgency=16

echo "julia main.jl --dataSet TRDataSet --version 2006 --epochs 100 --lemma --dropouts 0.3 --patience 6"
julia main.jl --dataSet TRDataSet --version 2006 --epochs 100 --lemma --dropouts 0.3 --patience 6
