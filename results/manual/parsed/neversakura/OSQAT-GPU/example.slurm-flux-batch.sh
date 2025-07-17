#!/bin/bash
#FLUX: --job-name=faux-eagle-9345
#FLUX: -t=1800
#FLUX: --urgency=16

JULIA_DEBUG=CUDA julia src/JOB.jl
