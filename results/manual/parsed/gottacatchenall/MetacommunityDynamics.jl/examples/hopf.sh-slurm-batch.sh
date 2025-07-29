#!/bin/bash
#FLUX: --job-name=hopf_inference
#FLUX: -t=2700
#FLUX: --urgency=16

module load julia/1.9.1
julia cluster_hopf_inference.jl
