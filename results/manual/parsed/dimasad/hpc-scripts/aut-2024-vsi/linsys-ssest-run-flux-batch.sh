#!/bin/bash
#FLUX: --job-name=purple-platanos-3254
#FLUX: --urgency=16

module purge
module load matlab
MATLABJOB_TEMPLATE='
addpath("/users/da00033/code/visid/examples/");
N = $ARG_N;
matfile = "$ARG_MATFILE";
outfile = "$ARG_OUTFILE";
nullsys0 = $ARG_NULLSYS0;
ssest_comp;'
MATLABJOB=$(envsubst <<< "$MATLABJOB_TEMPLATE" | tr -d '\n')
TARGET="$HOME/code/visid/examples/linsys_batches.py"
matlab -nodisplay -batch "$MATLABJOB"
