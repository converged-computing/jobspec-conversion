#!/bin/bash
#FLUX: --job-name=arid-nunchucks-0683
#FLUX: -n=4
#FLUX: --queue=node03-06
#FLUX: --urgency=15

SLURM_RESTART_COUNT=2
julia src/preprocess_swissprot.jl $@
