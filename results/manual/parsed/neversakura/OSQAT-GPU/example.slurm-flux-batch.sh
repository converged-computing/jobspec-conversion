#!/bin/bash
#FLUX --job-name=hello-fork-7722
#FLUX -t=1800
#FLUX --urgency=16

JULIA_DEBUG=CUDA julia src/JOB.jl
