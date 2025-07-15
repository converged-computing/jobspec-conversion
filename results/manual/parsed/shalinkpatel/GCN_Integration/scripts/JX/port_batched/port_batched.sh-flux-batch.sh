#!/bin/bash
#FLUX: --job-name=port_batched
#FLUX: -t=108000
#FLUX: --priority=16

source ~/ml/bin/activate
julia port_batched.jl
