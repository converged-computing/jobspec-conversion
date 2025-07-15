#!/bin/bash
#FLUX: --job-name=hanky-nunchucks-0807
#FLUX: -n=32
#FLUX: -t=86400
#FLUX: --priority=16

N_TASKS=31
PROJECT_DIR=$HOME/dev/OAR
VENV_DIR=$HOME/envs/oar
JULIA_BIN=$HOME/julia
date
ls -la
source $VENV_DIR/bin/activate
$JULIA_BIN $PROJECT_DIR/scripts/0_init/dist_test.jl $N_TASKS
echo --- END OF CUDA CHECK ---
echo All is quiet on the western front
