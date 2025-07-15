#!/bin/bash
#FLUX: --job-name=red-kitty-2639
#FLUX: --urgency=15

SLURM_RESTART_COUNT=2
julia src/preprocess_swissprot.jl $@
