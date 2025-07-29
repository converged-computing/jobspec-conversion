#!/bin/bash
#FLUX: --job-name=predictvisits_estsmp
#FLUX: --queue=covert-dingel
#FLUX: -t=7200
#FLUX: --urgency=16

module load julia/0.6.2
julia predictvisits_estsmp.jl
