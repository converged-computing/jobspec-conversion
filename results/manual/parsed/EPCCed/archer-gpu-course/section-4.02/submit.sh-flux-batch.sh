#!/bin/bash
#FLUX: --job-name=fuzzy-signal-0119
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --urgency=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
nsys profile -o graphprofile ./a.out
