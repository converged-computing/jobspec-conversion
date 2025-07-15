#!/bin/bash
#FLUX: --job-name=adorable-hippo-8015
#FLUX: -t=1800
#FLUX: --priority=16

JULIA_DEBUG=CUDA julia src/JOB.jl
