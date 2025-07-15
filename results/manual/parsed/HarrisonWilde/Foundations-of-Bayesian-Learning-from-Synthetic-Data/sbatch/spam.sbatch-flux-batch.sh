#!/bin/bash
#FLUX: --job-name=faux-mango-9846
#FLUX: -N=11
#FLUX: -t=172800
#FLUX: --urgency=16

export JULIA_PROJECT='/home/dcs/csrxgb/julia_stuff/Project.toml'
export JULIA_CMDSTAN_HOME='/home/dcs/csrxgb/julia_stuff/cmdstan-2.23.0'

export JULIA_PROJECT=/home/dcs/csrxgb/julia_stuff/Project.toml
export JULIA_CMDSTAN_HOME=/home/dcs/csrxgb/julia_stuff/cmdstan-2.23.0
module purge
module load GCC/8.3.0 GCCcore/9.2.0 Julia/1.4.1-linux-x86_64
julia ../src/logistic_regression/run.jl \
    --path /home/dcs/csrxgb/julia_stuff \
    --dataset uci_spambase \
    --label label \
    --epsilon 6.0 \
    --iterations 100 \
    --folds 5 \
    --sampler CmdStan \
    --distributed
