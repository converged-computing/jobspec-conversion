#!/bin/bash
#FLUX: --job-name=ou_cpmmh_kalman
#FLUX: --exclusive
#FLUX: -t=3600
#FLUX: --urgency=16

export JULIA_NUM_THREADS='1'

ml load GCC/6.4.0-2.28
ml load OpenMPI/2.1.2
ml load julia/1.0.0
pwd
cd ..
pwd
export JULIA_NUM_THREADS=1
julia /home/samwiq/'SDEMEM and CPMMH'/SDEMEM_and_CPMMH/src/'SDEMEM OU process'/run_script_kalman_for_plot_mess_vs_N.jl 19 #  seed
