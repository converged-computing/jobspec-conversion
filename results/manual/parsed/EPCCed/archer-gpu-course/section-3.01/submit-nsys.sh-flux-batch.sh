#!/bin/bash
#FLUX: --job-name=evasive-kitty-0406
#FLUX: --queue=gpu
#FLUX: -t=120
#FLUX: --urgency=16

export TMPDIR='$(pwd)'

module load nvidia/nvhpc
export TMPDIR=$(pwd)
nsys profile -o systems ./a.out
