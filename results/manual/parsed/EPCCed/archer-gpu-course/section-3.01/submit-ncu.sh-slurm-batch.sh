#!/bin/bash
#FLUX: --job-name=bricky-chip-0105
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --urgency=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
ncu -o default ./a.out
