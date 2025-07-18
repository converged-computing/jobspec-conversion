#!/bin/bash
#FLUX: --job-name=ou_cpmmh_099
#FLUX: --exclusive
#FLUX: --queue=lu
#FLUX: -t=72000
#FLUX: --urgency=16

export JULIA_NUM_THREADS='1'

ml load GCC/6.4.0-2.28
ml load OpenMPI/2.1.2
ml load julia/1.0.0
pwd
cd ..
pwd
export JULIA_NUM_THREADS=1
julia /home/samwiq/'SDEMEM and CPMMH'/SDEMEM_and_CPMMH/src/'SDEMEM OU neuron data'/run_script_cpmmh_bridge.jl 0.9 1 $1
