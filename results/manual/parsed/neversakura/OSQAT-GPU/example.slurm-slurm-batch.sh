#!/bin/bash
#FLUX: --job-name=cowy-despacito-1220
#FLUX: -t=1800
#FLUX: --urgency=16

JULIA_DEBUG=CUDA julia src/JOB.jl
