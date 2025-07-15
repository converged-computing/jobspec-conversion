#!/bin/bash
#FLUX: --job-name=crusty-blackbean-6937
#FLUX: -n=32
#FLUX: -t=86400
#FLUX: --priority=16

N_TASKS=31
PROJECT_DIR=$HOME/dev/DCCR
VENV_DIR=$HOME/envs/l2m
JULIA_BIN=$HOME/julia
date
ls -la
source $VENV_DIR/bin/activate
$JULIA_BIN $PROJECT_DIR/src/experiments/10_l2m_dist/3_dist_driver.jl $N_TASKS
echo --- END OF CUDA CHECK ---
echo All is quiet on the western front
