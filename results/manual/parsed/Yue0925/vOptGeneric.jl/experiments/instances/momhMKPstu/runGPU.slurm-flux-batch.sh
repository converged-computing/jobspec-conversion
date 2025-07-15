#!/bin/bash
#FLUX: --job-name=basic_algo
#FLUX: -c=20
#FLUX: --priority=16

source ~/.bashrc
for file in ./MOBKP/set3/*; do
    echo "$file"
    julia vOptMomkp.jl "$file"
done
