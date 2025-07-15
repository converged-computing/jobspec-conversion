#!/bin/bash
#FLUX: --job-name=liquid_gen
#FLUX: --queue=psych_gpu
#FLUX: -t=172800
#FLUX: --urgency=16

pwd; hostname; date
./run.sh julia src/exp_basic.jl 2/boxwithahole_16
date
if [[ "$@" =~ "on" ]];then
    rm -rf ../SPlisHSPlasH/bin/output/simulation_422
fi
