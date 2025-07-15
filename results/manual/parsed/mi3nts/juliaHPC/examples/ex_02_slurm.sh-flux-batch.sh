#!/bin/bash
#FLUX: --job-name=buttery-banana-4539
#FLUX: --urgency=16

echo Running on host: `hostname`
julia ex_02_factorial_function_simple.jl
