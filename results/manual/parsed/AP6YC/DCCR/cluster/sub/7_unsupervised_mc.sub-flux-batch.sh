#!/bin/bash
#FLUX: --job-name=fuzzy-rabbit-6573
#FLUX: -n=32
#FLUX: -t=86400
#FLUX: --priority=16

N_TASKS=31
PROJECT_DIR=$HOME/dev/DCCR
VENV_DIR=$HOME/.venv/DCCR
JULIA_BIN=$HOME/julia
date
ls -la
$JULIA_BIN $PROJECT_DIR/src/experiments/7_unsupervised_mc/7_unsupervised_mc.jl $N_TASKS
echo --- END OF CUDA CHECK ---
echo All is quiet on the western front
