#!/bin/bash
#FLUX: --job-name=port_batched
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=108000
#FLUX: --urgency=16

source ~/ml/bin/activate
julia port_batched.jl
