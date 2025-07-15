#!/bin/bash
#FLUX: --job-name=salted-truffle-0405
#FLUX: --exclusive
#FLUX: --urgency=16

export JULIA_NUM_THREADS='1'

ml load GCC/6.4.0-2.28
ml load OpenMPI/2.1.2
ml load julia/1.0.0
pwd
cd ..
pwd
export JULIA_NUM_THREADS=1
julia /home/samwiq/'SDEMEM and CPMMH'/SDEMEM_and_CPMMH/src/'SDEMEM OU process'/run_script_cpmmh_for_plot_mess_vs_N.jl 100 0.99 100 # M_mixtures N_time nbr_particles correlation seed
