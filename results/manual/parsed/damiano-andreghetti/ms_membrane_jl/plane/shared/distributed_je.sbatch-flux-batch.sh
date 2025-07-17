#!/bin/bash
#FLUX: --job-name=phase_separation
#FLUX: -c=28
#FLUX: --queue=boost_usr_prod
#FLUX: -t=36000
#FLUX: --urgency=16

source ~/.bashrc
julia -p 28 distributed_je.jl
