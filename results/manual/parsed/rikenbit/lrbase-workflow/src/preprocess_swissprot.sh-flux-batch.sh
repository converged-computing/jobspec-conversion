#!/bin/bash
#FLUX: --job-name=gassy-train-7809
#FLUX: --priority=15

SLURM_RESTART_COUNT=2
julia src/preprocess_swissprot.jl $@
