#!/bin/bash
#FLUX: --job-name=bricky-pancake-7610
#FLUX: -n=4
#FLUX: --queue=node03-06
#FLUX: --urgency=15

SLURM_RESTART_COUNT=2
julia src/preprocess_swissprot.jl $@
