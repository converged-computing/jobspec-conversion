#!/bin/bash
#FLUX: --job-name=loopy-lemon-6616
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --urgency=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
ncu -o default ./a.out
