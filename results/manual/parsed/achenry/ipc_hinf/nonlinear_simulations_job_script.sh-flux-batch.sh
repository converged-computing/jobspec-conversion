#!/bin/bash
#FLUX: --job-name=nonlin_sim
#FLUX: -n=64
#FLUX: --queue=amilan
#FLUX: -t=18000
#FLUX: --urgency=16

export CC='gcc'
export CXX='g++'

module purge
module load intel
module load mkl
module load matlab/R2022b
export CC=gcc
export CXX=g++
cd /projects/aohe7145/projects/ipc_tuning/code
matlab -nodisplay -nosplash -nodesktop -r "run('config.m'); STRUCT_PARAM_SWEEP = 0; EXTREME_K_COLLECTION = 0; BASELINE_K = 0; OPTIMAL_K_COLLECTION = 1; VARY_WU = 1; VARY_REFERENCE = 0; VARY_SATURATION = 0;; run('nonlinear_simulations.m'); exit;" | tail -n +11
