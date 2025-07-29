#!/bin/bash
#FLUX --job-name=sticky-soup-3231
#FLUX -t=1800
#FLUX --urgency=16

JULIA_DEBUG=CUDA julia src/JOB.jl
