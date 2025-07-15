#!/bin/bash
#FLUX: --job-name=scruptious-gato-5808
#FLUX: --priority=16

echo Running on host: `hostname`
julia ex_02_factorial_function_simple.jl
