#!/bin/bash
#FLUX: --job-name=expensive-cattywampus-8870
#FLUX: -t=1800
#FLUX: --urgency=16

JULIA_DEBUG=CUDA julia src/JOB.jl
