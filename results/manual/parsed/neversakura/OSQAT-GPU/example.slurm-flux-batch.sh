#!/bin/bash
#FLUX: --job-name=wobbly-onion-4760
#FLUX: -t=1800
#FLUX: --urgency=16

JULIA_DEBUG=CUDA julia src/JOB.jl
