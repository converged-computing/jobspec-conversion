#!/bin/bash
#FLUX: --job-name=factorialFunctionSimple
#FLUX: -t=60
#FLUX: --urgency=16

echo Running on host: `hostname`
julia ex_02_factorial_function_simple.jl
